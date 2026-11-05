import 'package:flutter/widgets.dart';

/// Motion tokens and the one easing curve the app uses.
abstract final class AppMotion {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration base = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);

  static const Curve curve = Curves.easeOutCubic;

  /// Collapses a duration when the platform asks for reduced motion.
  static Duration resolve(BuildContext context, Duration duration) {
    return MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;
  }
}
