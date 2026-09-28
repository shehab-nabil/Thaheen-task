import 'package:flutter/material.dart';

import '../../../../core/theme/app_semantic_colors.dart';

/// A seek bar that fills from the layout's start edge (right in Arabic,
/// left in English) rather than always from the physical left, with a
/// subtle tick marking the auto-completion point.
class RtlSeekBar extends StatefulWidget {
  const RtlSeekBar({
    required this.position,
    required this.duration,
    required this.completionThreshold,
    required this.onSeekEnd,
    this.onSeekStart,
    this.onSeeking,
    super.key,
  });

  final Duration position;
  final Duration duration;
  final double completionThreshold;
  final VoidCallback? onSeekStart;
  final ValueChanged<Duration>? onSeeking;
  final ValueChanged<Duration> onSeekEnd;

  @override
  State<RtlSeekBar> createState() => _RtlSeekBarState();
}

class _RtlSeekBarState extends State<RtlSeekBar> {
  double? _dragFraction;

  double get _fraction {
    if (_dragFraction != null) return _dragFraction!;
    final durationMs = widget.duration.inMilliseconds;
    if (durationMs <= 0) return 0;
    return (widget.position.inMilliseconds / durationMs).clamp(0.0, 1.0);
  }

  void _updateFraction(double dx, double width, TextDirection direction) {
    var fraction = width == 0 ? 0.0 : dx / width;
    if (direction == TextDirection.rtl) fraction = 1 - fraction;
    fraction = fraction.clamp(0.0, 1.0);
    setState(() => _dragFraction = fraction);
    widget.onSeeking?.call(widget.duration * fraction);
  }

  void _endDrag() {
    final fraction = _dragFraction;
    if (fraction != null) widget.onSeekEnd(widget.duration * fraction);
    setState(() => _dragFraction = null);
  }

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    final colors = Theme.of(context).colorScheme;
    final semantic = context.semanticColors;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: (_) => widget.onSeekStart?.call(),
          onHorizontalDragUpdate: (details) =>
              _updateFraction(details.localPosition.dx, width, direction),
          onHorizontalDragEnd: (_) => _endDrag(),
          onTapDown: (details) {
            widget.onSeekStart?.call();
            _updateFraction(details.localPosition.dx, width, direction);
          },
          onTapUp: (_) => _endDrag(),
          child: SizedBox(
            height: 24,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: semantic.track,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                FractionallySizedBox(
                  alignment: direction == TextDirection.rtl
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  widthFactor: _fraction,
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: direction,
                  start: (widget.completionThreshold * width - 1).clamp(
                    0.0,
                    width,
                  ),
                  child: Container(
                    width: 2,
                    height: 10,
                    color: semantic.border,
                  ),
                ),
                Positioned.directional(
                  textDirection: direction,
                  start: (_fraction * width - 7).clamp(0.0, width - 14),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
