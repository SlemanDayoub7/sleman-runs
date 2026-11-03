import 'package:flutter/material.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/app_typography.dart';
import 'package:sleman_runs/app/theme/pace_colors.dart';

/// Light and dark themes, both derived from one seed and one token set.
abstract final class AppTheme {
  /// Brand Ember, used by the scheme generator rather than directly.
  static const seed = Color(0xFFE8452A);

  static ThemeData get light => _build(
    brightness: Brightness.light,
    colors: AppColors.light,
    pace: PaceColors.light,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    colors: AppColors.dark,
    pace: PaceColors.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppColors colors,
    required PaceColors pace,
  }) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: seed,
          brightness: brightness,
        ).copyWith(
          primary: colors.primary,
          onPrimary: colors.onPrimary,
          primaryContainer: colors.primaryContainer,
          onPrimaryContainer: colors.textPrimary,
          surface: colors.surface,
          onSurface: colors.textPrimary,
          onSurfaceVariant: colors.textSecondary,
          outline: colors.outline,
          error: colors.error,
        );

    final base = ThemeData(colorScheme: scheme, useMaterial3: true);

    return base.copyWith(
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      dividerColor: colors.outline,
      textTheme: buildTextTheme(base.textTheme),
      extensions: <ThemeExtension<dynamic>>[colors, pace],
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
