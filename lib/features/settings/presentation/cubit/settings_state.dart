import 'package:equatable/equatable.dart';
import 'package:sleman_runs/core/error/failure.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';

/// State of the settings screen and, indirectly, of the whole app shell.
sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

/// Settings loaded or successfully written.
final class SettingsReady extends SettingsState {
  const SettingsReady(this.settings);

  final AppSettings settings;

  @override
  List<Object?> get props => [settings];
}

/// Settings could not be read or written.
///
/// Carries the last known-good settings so a failed write never strips the
/// user's theme or language mid-session.
final class SettingsFailed extends SettingsState {
  const SettingsFailed(this.failure, this.settings);

  final Failure failure;
  final AppSettings settings;

  @override
  List<Object?> get props => [failure, settings];
}

extension SettingsStateX on SettingsState {
  /// The settings to render, whichever branch of the state we are in.
  AppSettings get currentSettings => switch (this) {
    SettingsReady(:final settings) => settings,
    SettingsFailed(:final settings) => settings,
  };
}
