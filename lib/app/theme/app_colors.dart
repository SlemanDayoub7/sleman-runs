import 'package:flutter/material.dart';

/// Semantic colour tokens for the app chrome.
///
/// Widgets read these through [Theme.of] so dark mode is a token swap, never
/// an `if (isDark)` branch. Contrast pairs are verified in
/// `test/app/theme/contrast_test.dart`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.outline,
    required this.textPrimary,
    required this.textSecondary,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.accent,
    required this.success,
    required this.warning,
    required this.error,
    required this.gpsLocked,
  });

  static const light = AppColors(
    background: Color(0xFFF7F8FA),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFEDEFF3),
    outline: Color(0xFFD3D8E0),
    textPrimary: Color(0xFF101419),
    textSecondary: Color(0xFF5A6472),
    primary: Color(0xFFD63F26),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFE3DC),
    accent: Color(0xFF6C8A00),
    success: Color(0xFF0E7A4E),
    warning: Color(0xFFB45309),
    error: Color(0xFFC02626),
    gpsLocked: Color(0xFF0E7490),
  );

  static const dark = AppColors(
    background: Color(0xFF0B0F14),
    surface: Color(0xFF12171F),
    surfaceVariant: Color(0xFF1B222C),
    outline: Color(0xFF2C3542),
    textPrimary: Color(0xFFF2F5F8),
    textSecondary: Color(0xFF9AA6B5),
    primary: Color(0xFFFF7A5F),
    onPrimary: Color(0xFF2B0A03),
    primaryContainer: Color(0xFF5A1A0C),
    accent: Color(0xFFC8F135),
    success: Color(0xFF3DDC97),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFFF6B6B),
    gpsLocked: Color(0xFF22D3EE),
  );

  /// App background, behind all surfaces.
  final Color background;

  /// Cards, sheets, navigation bar.
  final Color surface;

  /// Inputs, dividers, subtle fills.
  final Color surfaceVariant;

  /// Hairlines and borders.
  final Color outline;

  /// Titles, metrics, primary copy.
  final Color textPrimary;

  /// Labels, metadata, supporting copy.
  final Color textSecondary;

  /// Primary actions and live-run emphasis.
  final Color primary;

  /// Content on top of [primary].
  final Color onPrimary;

  /// Selected chips and highlighted rows.
  final Color primaryContainer;

  /// Personal records and achievements only.
  final Color accent;

  final Color success;
  final Color warning;
  final Color error;

  /// Signal acquired, used by the tracking screen.
  final Color gpsLocked;

  @override
  AppColors copyWith({
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? outline,
    Color? textPrimary,
    Color? textSecondary,
    Color? primary,
    Color? onPrimary,
    Color? primaryContainer,
    Color? accent,
    Color? success,
    Color? warning,
    Color? error,
    Color? gpsLocked,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      outline: outline ?? this.outline,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      accent: accent ?? this.accent,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      gpsLocked: gpsLocked ?? this.gpsLocked,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) {
      return this;
    }
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t)!,
      primaryContainer: Color.lerp(
        primaryContainer,
        other.primaryContainer,
        t,
      )!,
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      gpsLocked: Color.lerp(gpsLocked, other.gpsLocked, t)!,
    );
  }
}
