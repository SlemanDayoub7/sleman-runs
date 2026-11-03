import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleman_runs/core/error/failure.dart';
import 'package:sleman_runs/core/result/result.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/domain/repositories/settings_repository.dart';

const _themeModeKey = 'settings.theme_mode';
const _languageKey = 'settings.language';

/// Stores preferences in the platform key-value store.
final class PreferencesSettingsRepository implements SettingsRepository {
  const PreferencesSettingsRepository(this._preferences);

  final SharedPreferences _preferences;

  @override
  Future<Result<AppSettings>> read() async {
    try {
      return ok(
        AppSettings(
          themeMode: _themeModeFrom(_preferences.getString(_themeModeKey)),
          language: _languageFrom(_preferences.getString(_languageKey)),
        ),
      );
    } on Object catch (error) {
      return err(StorageFailure(cause: error));
    }
  }

  @override
  Future<Result<AppSettings>> write(AppSettings settings) async {
    try {
      await _preferences.setString(_themeModeKey, settings.themeMode.name);
      await _preferences.setString(_languageKey, settings.language.name);
      return ok(settings);
    } on Object catch (error) {
      return err(StorageFailure(cause: error));
    }
  }
}

/// Unknown or missing values fall back to `system` instead of throwing: a
/// corrupted preference should never prevent the app from starting.
AppThemeMode _themeModeFrom(String? raw) {
  for (final mode in AppThemeMode.values) {
    if (mode.name == raw) {
      return mode;
    }
  }
  return AppThemeMode.system;
}

AppLanguage _languageFrom(String? raw) {
  for (final language in AppLanguage.values) {
    if (language.name == raw) {
      return language;
    }
  }
  return AppLanguage.system;
}
