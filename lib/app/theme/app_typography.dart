import 'package:flutter/material.dart';

/// Bundled families. Nothing is fetched at runtime; the app must work offline
/// on first launch.
abstract final class AppFonts {
  static const String latin = 'Manrope';
  static const String arabic = 'IBM Plex Sans Arabic';
  static const String mono = 'JetBrains Mono';
}

const _tabularFigures = <FontFeature>[FontFeature.tabularFigures()];

/// Builds the Design type scale for one locale.
///
/// Manrope and JetBrains Mono are variable fonts, so weight is set through the
/// `wght` axis instead of relying on synthetic bold. IBM Plex Sans Arabic ships
/// as static faces, so it uses [TextStyle.fontWeight] only.
TextTheme buildTextTheme({
  required bool arabic,
  required Color primaryText,
  required Color secondaryText,
}) {
  final metric = _style(
    size: 56,
    lineHeight: 60 / 56,
    weight: 700,
    color: primaryText,
    arabic: arabic,
    monospaced: true,
    features: _tabularFigures,
  );
  final h1 = _style(
    size: 32,
    lineHeight: 38 / 32,
    weight: 700,
    color: primaryText,
    arabic: arabic,
  );
  final h2 = _style(
    size: 24,
    lineHeight: 30 / 24,
    weight: 600,
    color: primaryText,
    arabic: arabic,
  );
  final h3 = _style(
    size: 19,
    lineHeight: 26 / 19,
    weight: 600,
    color: primaryText,
    arabic: arabic,
  );
  final body = _style(
    size: 16,
    lineHeight: 24 / 16,
    weight: 400,
    color: primaryText,
    arabic: arabic,
  );
  final label = _style(
    size: 14,
    lineHeight: 20 / 14,
    weight: 500,
    color: primaryText,
    arabic: arabic,
  );
  final caption = _style(
    size: 12,
    lineHeight: 16 / 12,
    weight: 500,
    color: secondaryText,
    arabic: arabic,
  );

  return TextTheme(
    displayLarge: metric,
    displayMedium: _style(
      size: 40,
      lineHeight: 44 / 40,
      weight: 700,
      color: primaryText,
      arabic: arabic,
      monospaced: true,
      features: _tabularFigures,
    ),
    displaySmall: h1,
    headlineLarge: h1,
    headlineMedium: h2,
    headlineSmall: _style(
      size: 22,
      lineHeight: 28 / 22,
      weight: 600,
      color: primaryText,
      arabic: arabic,
    ),
    titleLarge: _style(
      size: 20,
      lineHeight: 28 / 20,
      weight: 600,
      color: primaryText,
      arabic: arabic,
    ),
    titleMedium: h3,
    titleSmall: _style(
      size: 16,
      lineHeight: 22 / 16,
      weight: 600,
      color: primaryText,
      arabic: arabic,
    ),
    bodyLarge: body,
    bodyMedium: _style(
      size: 14,
      lineHeight: 22 / 14,
      weight: 400,
      color: primaryText,
      arabic: arabic,
    ),
    bodySmall: _style(
      size: 12,
      lineHeight: 16 / 12,
      weight: 400,
      color: secondaryText,
      arabic: arabic,
    ),
    labelLarge: label,
    labelMedium: _style(
      size: 12,
      lineHeight: 18 / 12,
      weight: 500,
      color: primaryText,
      arabic: arabic,
    ),
    labelSmall: caption,
  );
}

TextStyle _style({
  required double size,
  required double lineHeight,
  required int weight,
  required Color color,
  required bool arabic,
  bool monospaced = false,
  List<FontFeature>? features,
}) {
  final family = monospaced
      ? AppFonts.mono
      : arabic
      ? AppFonts.arabic
      : AppFonts.latin;
  final isVariable = monospaced || !arabic;

  return TextStyle(
    fontFamily: family,
    fontSize: size,
    height: arabic && !monospaced ? lineHeight * 1.1 : lineHeight,
    fontWeight: _fontWeight(weight),
    fontVariations: isVariable
        ? <FontVariation>[FontVariation('wght', weight.toDouble())]
        : null,
    color: color,
    fontFeatures: features,
  );
}

FontWeight _fontWeight(int value) {
  return switch (value) {
    500 => FontWeight.w500,
    600 => FontWeight.w600,
    700 => FontWeight.w700,
    _ => FontWeight.w400,
  };
}
