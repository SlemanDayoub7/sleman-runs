import 'package:equatable/equatable.dart';

/// How the app resolves light and dark.
///
/// Deliberately separate from Flutter's theme mode so the domain layer stays
/// free of Flutter imports.
enum AppThemeMode { system, light, dark }

/// Language preference. `system` follows the device locale.
enum AppLanguage { system, english, arabic }

/// Everything the user can configure, as one immutable value.
final class AppSettings extends Equatable {
  const AppSettings({
    this.themeMode = AppThemeMode.system,
    this.language = AppLanguage.system,
  });

  final AppThemeMode themeMode;
  final AppLanguage language;

  AppSettings copyWith({AppThemeMode? themeMode, AppLanguage? language}) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [themeMode, language];
}
