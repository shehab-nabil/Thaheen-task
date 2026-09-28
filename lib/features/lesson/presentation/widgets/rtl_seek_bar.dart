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
  static const double _trackAreaHeight = 24;
  static const double _trackThickness = 4;
  static const double _tickWidth = 2;
  static const double _tickHeight = 10;
  static const double _thumbSize = 14;

  static const double _trackTopOffset =
      (_trackAreaHeight - _trackThickness) / 2;
  static const double _tickTopOffset = (_trackAreaHeight - _tickHeight) / 2;
  static const double _thumbTopOffset = (_trackAreaHeight - _thumbSize) / 2;

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
            height: _trackAreaHeight,
            child: Stack(
              // Every child below is Positioned/Positioned.directional.
              // Non-positioned Stack children (a bare Container, or a
              // FractionallySizedBox — its own `alignment` only governs its
              // *child*, not where the box itself sits in the Stack) get
              // centered by Stack's alignment once they're narrower than
              // the full width, which is what made the fill look like it
              // grew from the middle instead of the start edge.
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: _trackTopOffset,
                  child: Container(
                    height: _trackThickness,
                    decoration: BoxDecoration(
                      color: semantic.track,
                      borderRadius: BorderRadius.circular(_trackThickness / 2),
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: direction,
                  start: 0,
                  top: _trackTopOffset,
                  width: _fraction * width,
                  height: _trackThickness,
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(_trackThickness / 2),
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: direction,
                  start: (widget.completionThreshold * width - _tickWidth / 2)
                      .clamp(0.0, width),
                  top: _tickTopOffset,
                  child: Container(
                    width: _tickWidth,
                    height: _tickHeight,
                    color: semantic.border,
                  ),
                ),
                Positioned.directional(
                  textDirection: direction,
                  start: (_fraction * width - _thumbSize / 2).clamp(
                    0.0,
                    width - _thumbSize,
                  ),
                  top: _thumbTopOffset,
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
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
