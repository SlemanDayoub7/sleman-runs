import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleman_runs/app/di/injection.dart';
import 'package:sleman_runs/features/settings/data/repositories/preferences_settings_repository.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/domain/repositories/settings_repository.dart';
import 'package:sleman_runs/features/settings/domain/usecases/read_settings.dart';
import 'package:sleman_runs/features/settings/domain/usecases/write_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({
      'settings.theme_mode': 'dark',
      'settings.language': 'arabic',
    });
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  test('resolves every registered type', () {
    expect(getIt<SharedPreferences>(), isA<SharedPreferences>());
    expect(getIt<SettingsRepository>(), isA<PreferencesSettingsRepository>());
    expect(getIt<ReadSettings>(), isA<ReadSettings>());
    expect(getIt<WriteSettings>(), isA<WriteSettings>());
    expect(getIt<SettingsCubit>(), isA<SettingsCubit>());
    expect(getIt<GoRouter>(), isA<GoRouter>());
  });

  test('reads persisted preferences through the use case', () async {
    final result = await getIt<ReadSettings>()();

    final settings = result.fold(
      (failure) => const AppSettings(),
      (settings) => settings,
    );

    expect(settings.themeMode, AppThemeMode.dark);
    expect(settings.language, AppLanguage.arabic);
  });

  test('returns a factory-fresh cubit on every resolution', () {
    final first = getIt<SettingsCubit>();
    final second = getIt<SettingsCubit>();

    expect(first, isNot(same(second)));
  });
}
