import 'package:flutter/material.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/app_component_theme.dart';
import 'package:sleman_runs/app/theme/app_typography.dart';
import 'package:sleman_runs/app/theme/pace_colors.dart';

/// The four theme variants the app can render.
///
/// Brightness and locale are combined because typography depends on the
/// writing system, not only on dark mode. Each variant is built once.
enum AppThemeVariant {
  lightEn(Brightness.light, Locale('en')),
  lightAr(Brightness.light, Locale('ar')),
  darkEn(Brightness.dark, Locale('en')),
  darkAr(Brightness.dark, Locale('ar'))
  ;

  const AppThemeVariant(this.brightness, this.locale);

  final Brightness brightness;
  final Locale locale;

  bool get isArabic => locale.languageCode == 'ar';
}

/// Light and dark themes derived from one seed and one token set.
///
/// The four variants are `static final`, so selecting a theme is a lookup,
/// not a rebuild of [ThemeData] on every frame.
abstract final class AppTheme {
  /// Brand Ember, used by the scheme generator rather than directly.
  static const Color seed = Color(0xFFE8452A);

  static final ThemeData lightEn = _build(AppThemeVariant.lightEn);
  static final ThemeData lightAr = _build(AppThemeVariant.lightAr);
  static final ThemeData darkEn = _build(AppThemeVariant.darkEn);
  static final ThemeData darkAr = _build(AppThemeVariant.darkAr);

  /// The cached theme for a brightness and resolved app language.
  static ThemeData forLocale({
    required Brightness brightness,
    required bool arabic,
  }) {
    return switch ((brightness, arabic)) {
      (Brightness.light, false) => lightEn,
      (Brightness.light, true) => lightAr,
      (Brightness.dark, false) => darkEn,
      (Brightness.dark, true) => darkAr,
    };
  }

  /// The cached theme for a golden-test variant.
  static ThemeData of(AppThemeVariant variant) {
    return forLocale(
      brightness: variant.brightness,
      arabic: variant.isArabic,
    );
  }

  static ThemeData _build(AppThemeVariant variant) {
    final colors = variant.brightness == Brightness.light
        ? AppColors.light
        : AppColors.dark;
    final pace = variant.brightness == Brightness.light
        ? PaceColors.light
        : PaceColors.dark;

    final scheme =
        ColorScheme.fromSeed(
          seedColor: seed,
          brightness: variant.brightness,
        ).copyWith(
          primary: colors.primary,
          onPrimary: colors.onPrimary,
          primaryContainer: colors.primaryContainer,
          onPrimaryContainer: colors.textPrimary,
          surface: colors.surface,
          onSurface: colors.textPrimary,
          onSurfaceVariant: colors.textSecondary,
          surfaceContainerLowest: colors.background,
          surfaceContainerLow: colors.surface,
          surfaceContainer: colors.surface,
          surfaceContainerHigh: colors.surfaceVariant,
          surfaceContainerHighest: colors.surfaceVariant,
          outline: colors.outline,
          outlineVariant: colors.outline,
          error: colors.error,
          onError: colors.onPrimary,
          onErrorContainer: colors.textPrimary,
          tertiary: colors.accent,
        );

    final textTheme = buildTextTheme(
      arabic: variant.isArabic,
      primaryText: colors.textPrimary,
      secondaryText: colors.textSecondary,
    );

    final base = ThemeData(
      brightness: variant.brightness,
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      dividerColor: colors.outline,
      splashFactory: InkSparkle.splashFactory,
      visualDensity: VisualDensity.standard,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      extensions: <ThemeExtension<dynamic>>[colors, pace],
    );

    return applyAppComponentThemes(
      base: base,
      colors: colors,
      textTheme: textTheme,
      brightness: variant.brightness,
    );
  }
}
