import 'package:flutter/material.dart';

/// Tabular figures keep timers and paces from jittering as digits change.
const _tabularFigures = <FontFeature>[FontFeature.tabularFigures()];

/// Builds the app type scale on top of the platform default.
///
/// Manrope and JetBrains Mono are bundled in Week 2 with their OFL licences;
/// until then the platform font is used so the app stays buildable without
/// binary assets in git.
TextTheme buildTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      fontSize: 56,
      height: 1.07,
      fontWeight: FontWeight.w700,
      letterSpacing: -1,
      fontFeatures: _tabularFigures,
    ),
    displayMedium: base.displayMedium?.copyWith(
      fontSize: 40,
      height: 1.1,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      fontFeatures: _tabularFigures,
    ),
    headlineSmall: base.headlineSmall?.copyWith(
      fontSize: 24,
      height: 1.25,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontSize: 19,
      height: 1.35,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: base.bodyMedium?.copyWith(fontSize: 16, height: 1.5),
    labelLarge: base.labelLarge?.copyWith(
      fontSize: 14,
      height: 1.4,
      fontWeight: FontWeight.w600,
    ),
    labelSmall: base.labelSmall?.copyWith(
      fontSize: 12,
      height: 1.35,
      fontWeight: FontWeight.w500,
    ),
  );
}
