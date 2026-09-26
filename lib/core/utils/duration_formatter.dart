class DurationFormatter {
  const DurationFormatter._();

  /// Formats a duration as `m:ss`, or `h:mm:ss` past one hour.
  /// Always renders Latin digits regardless of locale.
  static String format(Duration duration) {
    final totalSeconds = duration.inSeconds.clamp(0, double.maxFinite.toInt());
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    final secondsStr = seconds.toString().padLeft(2, '0');
    if (hours > 0) {
      final minutesStr = minutes.toString().padLeft(2, '0');
      return '$hours:$minutesStr:$secondsStr';
    }
    return '$minutes:$secondsStr';
  }
}
