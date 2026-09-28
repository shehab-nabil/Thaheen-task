import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/duration_formatter.dart';
import '../../../../generated/l10n.dart';
import 'rtl_seek_bar.dart';

class PlayerControlsOverlay extends StatefulWidget {
  const PlayerControlsOverlay({
    required this.position,
    required this.duration,
    required this.isPlaying,
    required this.speed,
    required this.completionThreshold,
    required this.onTogglePlayPause,
    required this.onSeekEnd,
    required this.onSpeedTap,
    required this.onFullscreenTap,
    this.isFullscreen = false,
    this.canGoNext,
    this.onNextLesson,
    super.key,
  });

  final Duration position;
  final Duration duration;
  final bool isPlaying;
  final double speed;
  final double completionThreshold;
  final VoidCallback onTogglePlayPause;
  final ValueChanged<Duration> onSeekEnd;
  final VoidCallback onSpeedTap;
  final VoidCallback onFullscreenTap;
  final bool isFullscreen;

  /// Fullscreen only: whether the next lesson is unlocked. Null hides the
  /// "الدرس التالي" control entirely (the non-fullscreen page shows its own
  /// NextLessonCard below the video instead).
  final bool? canGoNext;
  final VoidCallback? onNextLesson;

  @override
  State<PlayerControlsOverlay> createState() => _PlayerControlsOverlayState();
}

class _PlayerControlsOverlayState extends State<PlayerControlsOverlay> {
  static const Duration _autoHideDelay = Duration(seconds: 3);

  bool _visible = true;
  Timer? _hideTimer;
  bool _isSeeking = false;

  @override
  void initState() {
    super.initState();
    _scheduleAutoHide();
  }

  @override
  void didUpdateWidget(covariant PlayerControlsOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying == oldWidget.isPlaying) return;
    if (widget.isPlaying) {
      _scheduleAutoHide();
    } else {
      // Paused: cancel any pending hide and make sure controls are visible
      // again. No setState needed — build already runs after this.
      _hideTimer?.cancel();
      _visible = true;
    }
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  void _scheduleAutoHide() {
    _hideTimer?.cancel();
    if (!widget.isPlaying) return;
    _hideTimer = Timer(_autoHideDelay, () {
      if (mounted && !_isSeeking) setState(() => _visible = false);
    });
  }

  void _toggleVisible() {
    setState(() => _visible = !_visible);
    if (_visible) _scheduleAutoHide();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleVisible,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: IgnorePointer(
          ignoring: !_visible,
          child: Container(
            color: Colors.black.withValues(alpha: 0.35),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (widget.canGoNext != null)
                      TextButton.icon(
                        onPressed: widget.canGoNext!
                            ? widget.onNextLesson
                            : null,
                        icon: Icon(
                          widget.canGoNext!
                              ? Icons.skip_next_rounded
                              : Icons.lock_outline_rounded,
                          color: Colors.white,
                        ),
                        label: Text(
                          s.nextLessonLabel,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    IconButton(
                      onPressed: widget.onFullscreenTap,
                      icon: Icon(
                        widget.isFullscreen
                            ? Icons.fullscreen_exit_rounded
                            : Icons.fullscreen_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: IconButton(
                      iconSize: 48,
                      onPressed: widget.onTogglePlayPause,
                      icon: Icon(
                        widget.isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_filled_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Column(
                    children: [
                      RtlSeekBar(
                        position: widget.position,
                        duration: widget.duration,
                        completionThreshold: widget.completionThreshold,
                        onSeekStart: () {
                          _isSeeking = true;
                          _hideTimer?.cancel();
                        },
                        onSeekEnd: (value) {
                          _isSeeking = false;
                          widget.onSeekEnd(value);
                          _scheduleAutoHide();
                        },
                      ),
                      Row(
                        children: [
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              '${DurationFormatter.format(widget.position)} / '
                              '${DurationFormatter.format(widget.duration)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: widget.onSpeedTap,
                            child: Text(
                              s.speedMultiplier(
                                widget.speed == widget.speed.roundToDouble()
                                    ? widget.speed.toInt().toString()
                                    : widget.speed.toString(),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
