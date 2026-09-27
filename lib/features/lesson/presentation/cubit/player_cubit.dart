import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/shared/progress/domain/services/lesson_status.dart';
import '../../../../core/shared/progress/domain/services/progress_calculator.dart';
import '../../../../core/shared/progress/domain/usecases/mark_completed_use_case.dart';
import '../../../../core/shared/progress/domain/usecases/save_position_use_case.dart';
import '../../../../generated/l10n.dart';
import '../../domain/usecases/get_lesson_playback_data_use_case.dart';
import 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit(
    this._getLessonPlaybackDataUseCase,
    this._savePositionUseCase,
    this._markCompletedUseCase,
    this._calculator,
  ) : super(const PlayerState.initial());

  final GetLessonPlaybackDataUseCase _getLessonPlaybackDataUseCase;
  final SavePositionUseCase _savePositionUseCase;
  final MarkCompletedUseCase _markCompletedUseCase;
  final ProgressCalculator _calculator;

  static const Duration _saveInterval = Duration(seconds: 5);

  VideoPlayerController? _controller;
  Timer? _saveTimer;
  String? _lastVideoPath;

  Future<void> loadLesson({
    required String courseId,
    required String lessonId,
    required double initialSpeed,
  }) async {
    if (state is PlayerLoading) return;
    emit(const PlayerState.loading());

    final result = await _getLessonPlaybackDataUseCase(
      courseId: courseId,
      lessonId: lessonId,
    );
    if (isClosed) return;

    await result.fold(
      (failure) async => emit(PlayerState.failure(failure.message)),
      (data) async {
        final status = _calculator.statusesFor(
          lessonIds: data.lessonIdsInOrder,
          progressByLessonId: data.progressByLessonId,
        )[data.lessonIndex];
        final canGoNext = _calculator.canGoToNextLesson(
          lessonIds: data.lessonIdsInOrder,
          currentLessonId: lessonId,
          progressByLessonId: data.progressByLessonId,
        );
        final nextIndex = data.lessonIndex + 1;
        final nextLessonId = nextIndex < data.lessonIdsInOrder.length
            ? data.lessonIdsInOrder[nextIndex]
            : null;

        emit(
          PlayerState.ready(
            courseId: courseId,
            lessonId: lessonId,
            lessonTitle: data.lesson.title,
            sectionTitle: data.section.title,
            lessonIndex: data.lessonIndex,
            totalLessons: data.lessonIdsInOrder.length,
            status: status,
            canGoNext: canGoNext,
            nextLessonId: nextLessonId,
            position: Duration.zero,
            duration: Duration.zero,
            isPlaying: false,
            speed: initialSpeed,
            isCompleted: data.progress?.isCompleted ?? false,
          ),
        );

        await _initializeVideo(
          videoPath: data.lesson.video,
          savedPositionMs: data.progress?.positionMs ?? 0,
          initialSpeed: initialSpeed,
        );
      },
    );
  }

  /// Re-attempts initializing the video after a failure, without re-running
  /// the course/progress lookup.
  Future<void> retryVideo() async {
    final current = state;
    if (current is! PlayerReady) return;

    emit(current.copyWith(videoError: null));
    await _initializeVideo(
      videoPath: _lastVideoPath!,
      savedPositionMs: current.position.inMilliseconds,
      initialSpeed: current.speed,
    );
  }

  Future<void> _initializeVideo({
    required String videoPath,
    required int savedPositionMs,
    required double initialSpeed,
  }) async {
    _lastVideoPath = videoPath;
    final controller = VideoPlayerController.asset(videoPath);
    _controller = controller;

    try {
      await controller.initialize();
    } catch (_) {
      await controller.dispose();
      if (_controller == controller) _controller = null;
      if (isClosed) return;
      final current = state;
      if (current is PlayerReady) {
        emit(
          current.copyWith(
            videoError: VideoFailure(S.current.videoLoadError),
            controller: null,
          ),
        );
      }
      return;
    }
    if (isClosed) {
      await controller.dispose();
      return;
    }

    final resumeMs = _calculator.resumePositionMs(
      savedPositionMs: savedPositionMs,
      durationMs: controller.value.duration.inMilliseconds,
    );
    await controller.seekTo(Duration(milliseconds: resumeMs));
    await controller.setPlaybackSpeed(initialSpeed);
    controller.addListener(_onControllerUpdate);
    _startSaveTimer();

    if (isClosed) return;
    final current = state;
    if (current is! PlayerReady) return;
    emit(
      current.copyWith(
        controller: controller,
        position: controller.value.position,
        duration: controller.value.duration,
        videoError: null,
      ),
    );
  }

  void _onControllerUpdate() {
    if (isClosed) return;
    final controller = _controller;
    final current = state;
    if (controller == null || current is! PlayerReady) return;

    final value = controller.value;
    // OR in the platform's own "reached the end" signal: on a very short
    // clip, the last reported position can land a few ms short of the 99%
    // mark, and this still catches it as a real completion.
    final completedNow = value.isCompleted ||
        _calculator.isCompletedGiven(
          wasCompleted: current.isCompleted,
          positionMs: value.position.inMilliseconds,
          durationMs: value.duration.inMilliseconds,
        );

    if (completedNow && !current.isCompleted) {
      unawaited(
        _markCompletedUseCase(
          lessonId: current.lessonId,
          positionMs: value.position.inMilliseconds,
          durationMs: value.duration.inMilliseconds,
        ),
      );
    }

    emit(
      current.copyWith(
        position: value.position,
        duration: value.duration,
        isPlaying: value.isPlaying,
        isCompleted: completedNow,
        status: completedNow ? LessonStatus.completed : LessonStatus.inProgress,
        canGoNext: completedNow && current.nextLessonId != null,
      ),
    );
  }

  Future<void> togglePlayPause() async {
    final controller = _controller;
    if (controller == null) return;
    if (controller.value.isPlaying) {
      await controller.pause();
      await _persistPosition();
    } else {
      await controller.play();
    }
  }

  Future<void> seekTo(Duration position) async {
    final controller = _controller;
    if (controller == null) return;
    await controller.seekTo(position);
    await _persistPosition();
  }

  Future<void> setSpeed(double speed) async {
    final controller = _controller;
    final current = state;
    if (controller == null || current is! PlayerReady) return;
    await controller.setPlaybackSpeed(speed);
    if (isClosed) return;
    emit(current.copyWith(speed: speed));
  }

  /// Relayed by the page's WidgetsBindingObserver on AppLifecycleState.paused.
  void onAppPaused() {
    unawaited(_persistPosition());
  }

  void _startSaveTimer() {
    _saveTimer?.cancel();
    _saveTimer = Timer.periodic(_saveInterval, (_) {
      final current = state;
      if (current is PlayerReady && current.isPlaying) {
        unawaited(_persistPosition());
      }
    });
  }

  Future<void> _persistPosition() async {
    final controller = _controller;
    final current = state;
    if (controller == null || current is! PlayerReady) return;
    await _savePositionUseCase(
      lessonId: current.lessonId,
      positionMs: controller.value.position.inMilliseconds,
      durationMs: controller.value.duration.inMilliseconds,
    );
  }

  @override
  Future<void> close() async {
    _saveTimer?.cancel();
    await _persistPosition();
    _controller?.removeListener(_onControllerUpdate);
    await _controller?.dispose();
    return super.close();
  }
}
