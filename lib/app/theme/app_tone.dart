import 'package:flutter/painting.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';

/// Semantic foreground roles, shared by text and icons.
///
/// The enum exists so a widget cannot ask for `#FF6B6B`; it can only ask for
/// `error`, and the theme decides what error means in the current mode.
enum AppTone {
  primary,
  secondary,
  error,
  success,
  warning,
  accent,
  onPrimary,
  disabled
  ;

  Color color(AppColors colors) {
    return switch (this) {
      AppTone.primary => colors.primary,
      AppTone.secondary => colors.textSecondary,
      AppTone.error => colors.error,
      AppTone.success => colors.success,
      AppTone.warning => colors.warning,
      AppTone.accent => colors.accent,
      AppTone.onPrimary => colors.onPrimary,
      AppTone.disabled => colors.textSecondary.withValues(alpha: 0.55),
    };
  }
}
