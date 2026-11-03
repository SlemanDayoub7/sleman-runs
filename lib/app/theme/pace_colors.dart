import 'package:flutter/material.dart';

/// Pace-zone colours used by splits and charts.
///
/// Separated from the app colour tokens because these carry meaning (effort
/// level) rather than surface semantics, and should never be used for buttons.
@immutable
class PaceColors extends ThemeExtension<PaceColors> {
  const PaceColors({
    required this.recovery,
    required this.easy,
    required this.steady,
    required this.threshold,
    required this.interval,
  });

  static const light = PaceColors(
    recovery: Color(0xFF7C8B9E),
    easy: Color(0xFF2E9E7E),
    steady: Color(0xFF2563C9),
    threshold: Color(0xFFC2760B),
    interval: Color(0xFFC02626),
  );

  static const dark = PaceColors(
    recovery: Color(0xFF8C9AAD),
    easy: Color(0xFF3DDC97),
    steady: Color(0xFF60A5FA),
    threshold: Color(0xFFFBBF24),
    interval: Color(0xFFFF6B6B),
  );

  final Color recovery;
  final Color easy;
  final Color steady;
  final Color threshold;
  final Color interval;

  @override
  PaceColors copyWith({
    Color? recovery,
    Color? easy,
    Color? steady,
    Color? threshold,
    Color? interval,
  }) {
    return PaceColors(
      recovery: recovery ?? this.recovery,
      easy: easy ?? this.easy,
      steady: steady ?? this.steady,
      threshold: threshold ?? this.threshold,
      interval: interval ?? this.interval,
    );
  }

  @override
  PaceColors lerp(covariant PaceColors? other, double t) {
    if (other == null) {
      return this;
    }
    return PaceColors(
      recovery: Color.lerp(recovery, other.recovery, t)!,
      easy: Color.lerp(easy, other.easy, t)!,
      steady: Color.lerp(steady, other.steady, t)!,
      threshold: Color.lerp(threshold, other.threshold, t)!,
      interval: Color.lerp(interval, other.interval, t)!,
    );
  }
}
