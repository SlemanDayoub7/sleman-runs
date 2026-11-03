import 'package:flutter/material.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';

/// Maps the domain preference to Flutter's theme mode.
extension AppThemeModeX on AppThemeMode {
  ThemeMode get material => switch (this) {
    AppThemeMode.system => ThemeMode.system,
    AppThemeMode.light => ThemeMode.light,
    AppThemeMode.dark => ThemeMode.dark,
  };
}

/// Maps the domain preference to a [Locale].
///
/// `null` means "follow the device", which is what Flutter does when no locale
/// is supplied to `MaterialApp`.
extension AppLanguageX on AppLanguage {
  Locale? get locale => switch (this) {
    AppLanguage.system => null,
    AppLanguage.english => const Locale('en'),
    AppLanguage.arabic => const Locale('ar'),
  };
}
