import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/shared/progress/domain/services/progress_calculator.dart';
import '../../../lesson/presentation/cubit/player_cubit.dart';
import '../../../lesson/presentation/cubit/player_state.dart';
import '../../../lesson/presentation/widgets/player_controls_overlay.dart';
import '../../../lesson/presentation/widgets/speed_selector.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';

class FullscreenLessonPage extends StatefulWidget {
  const FullscreenLessonPage({required this.cubit, super.key});

  final PlayerCubit cubit;

  @override
  State<FullscreenLessonPage> createState() => _FullscreenLessonPageState();
}

class _FullscreenLessonPageState extends State<FullscreenLessonPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _restoreSystemUi();
    super.dispose();
  }

  void _restoreSystemUi() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  /// Pops back to the (still-alive) lesson page rather than pushReplacement
  /// from within fullscreen — replacing this route would leave the lesson
  /// route (and a second PlayerCubit) stranded underneath. The lesson page
  /// reads the [goToNext] result and does the actual next-lesson navigation
  /// itself, since it still owns this cubit either way.
  void _exit({required bool goToNext}) {
    _restoreSystemUi();
    Navigator.of(context).pop(goToNext);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PlayerCubit>.value(
      value: widget.cubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) _restoreSystemUi();
          },
          child: BlocBuilder<PlayerCubit, PlayerState>(
            buildWhen: (previous, current) => current is PlayerReady,
            builder: (context, state) {
              if (state is! PlayerReady || state.controller == null) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return Stack(
                fit: StackFit.expand,
                children: [
                  Center(child: _VideoSurface(controller: state.controller!)),
                  PlayerControlsOverlay(
                    position: state.position,
                    duration: state.duration,
                    isPlaying: state.isPlaying,
                    speed: state.speed,
                    completionThreshold: ProgressCalculator.completionThreshold,
                    isFullscreen: true,
                    canGoNext: state.canGoNext,
                    onTogglePlayPause: widget.cubit.togglePlayPause,
                    onSeekEnd: widget.cubit.seekTo,
                    onSpeedTap: () => openSpeedPicker(
                      context: context,
                      player: widget.cubit,
                      settings: context.read<SettingsCubit>(),
                      current: state.speed,
                    ),
                    onFullscreenTap: () => _exit(goToNext: false),
                    onNextLesson: () => _exit(goToNext: true),
                  ),
                ],
              );
            },
          ),
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
