import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/shared/progress/domain/services/lesson_status.dart';
import '../../../settings/data/models/localized_text_model.dart';

part 'player_state.freezed.dart';

@freezed
sealed class PlayerState with _$PlayerState {
  const factory PlayerState.initial() = PlayerInitial;

  const factory PlayerState.loading() = PlayerLoading;

  const factory PlayerState.ready({
    required String courseId,
    required String lessonId,
    required LocalizedTextModel lessonTitle,
    required LocalizedTextModel sectionTitle,
    required int lessonIndex,
    required int totalLessons,
    required LessonStatus status,
    required bool canGoNext,
    required Duration position,
    required Duration duration,
    required bool isPlaying,
    required double speed,
    required bool isCompleted,
    String? nextLessonId,
    VideoPlayerController? controller,
    VideoFailure? videoError,
  }) = PlayerReady;

  /// The lesson/course/progress lookup itself failed (not found, parse
  /// error). A video-asset failure is represented within [PlayerReady] via
  /// `videoError` instead, since the rest of the page stays usable then.
  const factory PlayerState.failure(String message) = PlayerFailure;
}
