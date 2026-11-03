import 'package:sleman_runs/core/utils/units.dart';

const _secondsPerHour = 3600;
const _secondsPerMinute = 60;

/// Formats an elapsed duration as `m:ss`, or `h:mm:ss` past one hour.
///
/// Minutes are not padded below an hour, because `5:07` reads better than
/// `05:07` and matches every running watch.
String formatDuration(Duration duration) {
  final totalSeconds = duration.inSeconds;
  final hours = totalSeconds ~/ _secondsPerHour;
  final minutes = (totalSeconds % _secondsPerHour) ~/ _secondsPerMinute;
  final seconds = totalSeconds % _secondsPerMinute;
  final paddedSeconds = seconds.toString().padLeft(2, '0');

  if (hours > 0) {
    final paddedMinutes = minutes.toString().padLeft(2, '0');
    return '$hours:$paddedMinutes:$paddedSeconds';
  }
  return '$minutes:$paddedSeconds';
}

/// Formats a distance in the user's unit with two decimals, no suffix.
String formatDistance(double meters, DistanceUnit unit) {
  final value = meters / unit.metersPerUnit;
  return value.toStringAsFixed(2);
}

/// Seconds per unit of distance, rounded to the nearest second.
///
/// Returns `null` when there is not enough data to compute a pace, so the UI
/// can render a placeholder instead of `Infinity`.
int? paceSecondsPerUnit({
  required Duration elapsed,
  required double meters,
  required DistanceUnit unit,
}) {
  if (meters <= 0 || elapsed.inSeconds <= 0) {
    return null;
  }
  final units = meters / unit.metersPerUnit;
  return (elapsed.inSeconds / units).round();
}

/// Formats a pace as `m:ss`, or `--:--` when it cannot be computed.
String formatPace({
  required Duration elapsed,
  required double meters,
  required DistanceUnit unit,
}) {
  final totalSeconds = paceSecondsPerUnit(
    elapsed: elapsed,
    meters: meters,
    unit: unit,
  );
  if (totalSeconds == null) {
    return '--:--';
  }
  final minutes = totalSeconds ~/ _secondsPerMinute;
  final seconds = totalSeconds % _secondsPerMinute;
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

/// Pace with its unit suffix, for example `5:42 /km`.
String formatPaceWithUnit({
  required Duration elapsed,
  required double meters,
  required DistanceUnit unit,
}) {
  return '${formatPace(elapsed: elapsed, meters: meters, unit: unit)} '
      '/${unit.suffix}';
}
