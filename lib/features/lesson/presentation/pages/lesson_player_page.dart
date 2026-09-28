import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/shared/progress/domain/services/progress_calculator.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../../generated/l10n.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../cubit/player_cubit.dart';
import '../cubit/player_state.dart';
import '../widgets/next_lesson_card.dart';
import '../widgets/player_controls_overlay.dart';
import '../widgets/speed_selector.dart';

class LessonPlayerPage extends StatefulWidget {
  const LessonPlayerPage({
    required this.courseId,
    required this.lessonId,
    super.key,
  });

  final String courseId;
  final String lessonId;

  @override
  State<LessonPlayerPage> createState() => _LessonPlayerPageState();
}

class _LessonPlayerPageState extends State<LessonPlayerPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final initialSpeed = context.read<SettingsCubit>().state.playbackSpeed;
    context.read<PlayerCubit>().loadLesson(
      courseId: widget.courseId,
      lessonId: widget.lessonId,
      initialSpeed: initialSpeed,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      context.read<PlayerCubit>().onAppPaused();
    }
  }

  void _openSpeedPicker(double current) {
    // A modal bottom sheet is pushed as its own route on the Navigator, so
    // its builder context sits outside the route-level BlocProvider that
    // scopes PlayerCubit to this page. Read both cubits here, before
    // opening the sheet, rather than from the sheet's own context.
    openSpeedPicker(
      context: context,
      player: context.read<PlayerCubit>(),
      settings: context.read<SettingsCubit>(),
      current: current,
    );
  }

  Future<void> _openFullscreen() async {
    final cubit = context.read<PlayerCubit>();
    final goToNext = await context.push<bool>(
      '/course/${widget.courseId}/lesson/${widget.lessonId}/fullscreen',
      extra: cubit,
    );
    if (!mounted || goToNext != true) return;

    // The fullscreen page pops back here rather than navigating directly,
    // so this (still-alive) cubit's own state is the source of truth for
    // where "next" actually goes.
    final state = cubit.state;
    if (state is PlayerReady && state.nextLessonId != null) {
      context.pushReplacement(
        '/course/${widget.courseId}/lesson/${state.nextLessonId}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: BlocBuilder<PlayerCubit, PlayerState>(
        // Rebuilds for a state *type* change (Initial/Loading/Ready/
        // Failure), and within Ready only for the fields _ReadyContent's
        // non-video parts actually render (title/section/status/next-lesson
        // eligibility). Position/duration/isPlaying/speed/controller tick
        // many times a second while playing; those are handled by _VideoArea's
        // own nested BlocBuilder below, so this one skipping them means the
        // title, status chip and Next Lesson card aren't rebuilt on every tick.
        buildWhen: (previous, current) {
          if (previous.runtimeType != current.runtimeType) return true;
          if (previous is PlayerReady && current is PlayerReady) {
            return previous.lessonTitle != current.lessonTitle ||
                previous.sectionTitle != current.sectionTitle ||
                previous.lessonIndex != current.lessonIndex ||
                previous.totalLessons != current.totalLessons ||
                previous.status != current.status ||
                previous.canGoNext != current.canGoNext ||
                previous.nextLessonId != current.nextLessonId;
          }
          return true;
        },
        builder: (context, state) {
          return switch (state) {
            PlayerInitial() ||
            PlayerLoading() => const Center(child: CircularProgressIndicator()),
            PlayerFailure(:final message) => AppErrorView(
              message: message,
              onRetry: () {
                final speed = context.read<SettingsCubit>().state.playbackSpeed;
                context.read<PlayerCubit>().loadLesson(
                  courseId: widget.courseId,
                  lessonId: widget.lessonId,
                  initialSpeed: speed,
                );
              },
            ),
            PlayerReady() => _ReadyContent(
              state: state,
              onOpenSpeedPicker: _openSpeedPicker,
              onOpenFullscreen: _openFullscreen,
            ),
          };
        },
      ),
    );
  }
}

class _ReadyContent extends StatelessWidget {
  const _ReadyContent({
    required this.state,
    required this.onOpenSpeedPicker,
    required this.onOpenFullscreen,
  });

  final PlayerReady state;
  final ValueChanged<double> onOpenSpeedPicker;
  final VoidCallback onOpenFullscreen;

  @override
  Widget build(BuildContext context) {
    final languageCode = context.select<SettingsCubit, String>(
      (c) => c.state.locale,
    );
    final theme = Theme.of(context);
    final s = S.of(context);

    return ListView(
      children: [
        _VideoArea(
          onOpenSpeedPicker: onOpenSpeedPicker,
          onOpenFullscreen: onOpenFullscreen,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.lessonOfTotalWithSection(
                  state.lessonIndex + 1,
                  state.totalLessons,
                  state.sectionTitle.resolve(languageCode),
                ),
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                state.lessonTitle.resolve(languageCode),
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              StatusChip(status: state.status),
              const SizedBox(height: AppSpacing.xs),
              Text(
                s.autoCompleteHint(
                  (ProgressCalculator.completionThreshold * 100).round(),
                ),
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: AppSpacing.lg),
              NextLessonCard(
                canGoNext: state.canGoNext,
                onTap: state.nextLessonId == null
                    ? null
                    : () => context.pushReplacement(
                        '/course/${state.courseId}/lesson/${state.nextLessonId}',
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The video surface + controls overlay, isolated in its own BlocBuilder so
/// the many-times-a-second position/duration/isPlaying ticks only rebuild
/// this subtree, not the title/status/Next-Lesson-card above (see the
/// buildWhen comment on the outer BlocBuilder in LessonPlayerPage).
class _VideoArea extends StatelessWidget {
  const _VideoArea({
    required this.onOpenSpeedPicker,
    required this.onOpenFullscreen,
  });

  final ValueChanged<double> onOpenSpeedPicker;
  final VoidCallback onOpenFullscreen;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ColoredBox(
        color: Colors.black,
        child: BlocBuilder<PlayerCubit, PlayerState>(
          buildWhen: (previous, current) {
            if (current is! PlayerReady) return false;
            if (previous is! PlayerReady) return true;
            return previous.position != current.position ||
                previous.duration != current.duration ||
                previous.isPlaying != current.isPlaying ||
                previous.speed != current.speed ||
                previous.controller != current.controller ||
                previous.videoError != current.videoError;
          },
          builder: (context, state) {
            if (state is! PlayerReady) return const SizedBox.shrink();

            if (state.videoError != null) {
              return _VideoErrorView(message: state.videoError!.message);
            }
            if (state.controller == null) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return Stack(
              fit: StackFit.expand,
              children: [
                _VideoSurface(controller: state.controller!),
                PlayerControlsOverlay(
                  position: state.position,
                  duration: state.duration,
                  isPlaying: state.isPlaying,
                  speed: state.speed,
                  completionThreshold: ProgressCalculator.completionThreshold,
                  onTogglePlayPause: context
                      .read<PlayerCubit>()
                      .togglePlayPause,
                  onSeekEnd: context.read<PlayerCubit>().seekTo,
                  onSpeedTap: () => onOpenSpeedPicker(state.speed),
                  onFullscreenTap: onOpenFullscreen,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _VideoSurface extends StatelessWidget {
  const _VideoSurface({required this.controller});

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: controller.value.size.width,
        height: controller.value.size.height,
        child: VideoPlayer(controller),
      ),
    );
  }
}

class _VideoErrorView extends StatelessWidget {
  const _VideoErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.amber,
              size: 40,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              s.videoLoadErrorBody,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton(
              onPressed: () => context.read<PlayerCubit>().retryVideo(),
              child: Text(s.retry),
            ),
          ],
        ),
      ),
    );
  }
}
