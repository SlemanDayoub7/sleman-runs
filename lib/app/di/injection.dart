import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleman_runs/app/router/app_router.dart';
import 'package:sleman_runs/features/settings/data/repositories/preferences_settings_repository.dart';
import 'package:sleman_runs/features/settings/domain/repositories/settings_repository.dart';
import 'package:sleman_runs/features/settings/domain/usecases/read_settings.dart';
import 'package:sleman_runs/features/settings/domain/usecases/write_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';

/// The one container in the app.
///
/// Registration is explicit and manual: this file is the readable dependency
/// graph. Nothing else in the codebase calls `GetIt.I`, because hidden
/// dependencies are what dependency injection exists to prevent.
final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  final preferences = await SharedPreferences.getInstance();

  getIt
    ..registerSingleton<SharedPreferences>(preferences)
    ..registerLazySingleton<SettingsRepository>(
      () => PreferencesSettingsRepository(getIt()),
    )
    ..registerFactory(() => ReadSettings(getIt()))
    ..registerFactory(() => WriteSettings(getIt()))
    ..registerFactory(
      () => SettingsCubit(
        readSettings: getIt(),
        writeSettings: getIt(),
      ),
    )
    ..registerLazySingleton<GoRouter>(createRouter);
}
