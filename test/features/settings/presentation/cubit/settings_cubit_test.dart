import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sleman_runs/core/error/failure.dart';
import 'package:sleman_runs/core/result/result.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/domain/repositories/settings_repository.dart';
import 'package:sleman_runs/features/settings/domain/usecases/read_settings.dart';
import 'package:sleman_runs/features/settings/domain/usecases/write_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_state.dart';

class _MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late _MockSettingsRepository repository;
  late SettingsCubit cubit;

  setUpAll(() {
    registerFallbackValue(const AppSettings());
  });

  setUp(() {
    repository = _MockSettingsRepository();
    cubit = SettingsCubit(
      readSettings: ReadSettings(repository),
      writeSettings: WriteSettings(repository),
    );
  });

  tearDown(() async {
    if (!cubit.isClosed) {
      await cubit.close();
    }
  });

  group('load', () {
    blocTest<SettingsCubit, SettingsState>(
      'emits the stored settings',
      setUp: () {
        when(() => repository.read()).thenAnswer(
          (_) async => ok(
            const AppSettings(
              themeMode: AppThemeMode.dark,
              language: AppLanguage.arabic,
            ),
          ),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<SettingsReady>()
            .having((s) => s.settings.themeMode, 'themeMode', AppThemeMode.dark)
            .having((s) => s.settings.language, 'language', AppLanguage.arabic),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'falls back to defaults and reports the failure',
      setUp: () {
        when(
          () => repository.read(),
        ).thenAnswer((_) async => err(const StorageFailure()));
      },
      build: () => cubit,
      act: (cubit) => cubit.load(),
      expect: () => [
        isA<SettingsFailed>()
            .having((s) => s.failure, 'failure', isA<StorageFailure>())
            .having(
              (s) => s.settings.themeMode,
              'themeMode',
              AppThemeMode.system,
            ),
      ],
    );
  });

  group('setThemeMode', () {
    blocTest<SettingsCubit, SettingsState>(
      'persists and emits the saved settings',
      setUp: () {
        when(() => repository.write(any())).thenAnswer(
          (invocation) async =>
              ok(invocation.positionalArguments.first as AppSettings),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.setThemeMode(AppThemeMode.dark),
      expect: () => [
        isA<SettingsReady>().having(
          (s) => s.settings.themeMode,
          'themeMode',
          AppThemeMode.dark,
        ),
      ],
      verify: (_) {
        verify(
          () => repository.write(
            const AppSettings(themeMode: AppThemeMode.dark),
          ),
        ).called(1);
      },
    );

    blocTest<SettingsCubit, SettingsState>(
      'keeps the previous settings when the write fails',
      setUp: () {
        when(
          () => repository.write(any()),
        ).thenAnswer((_) async => err(const StorageFailure()));
      },
      build: () => cubit,
      act: (cubit) => cubit.setThemeMode(AppThemeMode.dark),
      expect: () => [
        isA<SettingsFailed>()
            .having((s) => s.failure, 'failure', isA<StorageFailure>())
            .having(
              (s) => s.settings.themeMode,
              'themeMode',
              AppThemeMode.system,
            ),
      ],
    );
  });

  blocTest<SettingsCubit, SettingsState>(
    'setLanguage persists the language and keeps the theme',
    setUp: () {
      when(() => repository.write(any())).thenAnswer(
        (invocation) async =>
            ok(invocation.positionalArguments.first as AppSettings),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.setLanguage(AppLanguage.arabic),
    expect: () => [
      isA<SettingsReady>()
          .having((s) => s.settings.language, 'language', AppLanguage.arabic)
          .having(
            (s) => s.settings.themeMode,
            'themeMode',
            AppThemeMode.system,
          ),
    ],
  );
}
