import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/domain/usecases/read_settings.dart';
import 'package:sleman_runs/features/settings/domain/usecases/write_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_state.dart';

/// Owns the two global preferences: theme mode and language.
///
/// It talks to use cases only, never to a repository or a storage plugin.
final class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required ReadSettings readSettings,
    required WriteSettings writeSettings,
  }) : _readSettings = readSettings,
       _writeSettings = writeSettings,
       super(const SettingsReady(AppSettings()));

  final ReadSettings _readSettings;
  final WriteSettings _writeSettings;

  /// Loads persisted settings. Called once during bootstrap, before the first
  /// frame, so the app never flashes the wrong theme or direction.
  Future<void> load() async {
    final result = await _readSettings();
    if (isClosed) {
      return;
    }
    result.fold(
      (failure) => emit(SettingsFailed(failure, state.currentSettings)),
      (settings) => emit(SettingsReady(settings)),
    );
  }

  Future<void> setThemeMode(AppThemeMode mode) {
    return _persist(state.currentSettings.copyWith(themeMode: mode));
  }

  Future<void> setLanguage(AppLanguage language) {
    return _persist(state.currentSettings.copyWith(language: language));
  }

  Future<void> _persist(AppSettings next) async {
    final previous = state.currentSettings;
    final result = await _writeSettings(next);
    if (isClosed) {
      return;
    }
    result.fold(
      (failure) => emit(SettingsFailed(failure, previous)),
      (settings) => emit(SettingsReady(settings)),
    );
  }
}
