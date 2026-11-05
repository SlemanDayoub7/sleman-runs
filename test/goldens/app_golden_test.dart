import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sleman_runs/app/theme/app_theme.dart';
import 'package:sleman_runs/features/history/presentation/pages/history_page.dart';
import 'package:sleman_runs/features/plans/presentation/pages/plan_page.dart';
import 'package:sleman_runs/features/settings/domain/usecases/read_settings.dart';
import 'package:sleman_runs/features/settings/domain/usecases/write_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sleman_runs/features/settings/presentation/pages/settings_page.dart';
import 'package:sleman_runs/features/tracking/presentation/pages/tracking_page.dart';

import '../support/fake_settings_repository.dart';
import '../support/load_fonts.dart';
import '../support/pump_themed.dart';

/// Pixel goldens are opt-in locally so a normal `flutter test` stays fast and
/// does not fail on font rasterisation differences between machines.
///
/// CI runs them on Windows, the same platform the baselines were generated on:
///
/// ```sh
/// RUN_GOLDENS=1 flutter test --update-goldens test/goldens
/// RUN_GOLDENS=1 flutter test test/goldens
/// ```
final _runGoldens = Platform.environment['RUN_GOLDENS'] == '1';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(loadAppFonts);

  late SettingsCubit settingsCubit;

  setUp(() {
    final repository = FakeSettingsRepository();
    settingsCubit = SettingsCubit(
      readSettings: ReadSettings(repository),
      writeSettings: WriteSettings(repository),
    );
  });

  tearDown(() async {
    await settingsCubit.close();
  });

  final screens = <String, Widget Function()>{
    'tracking': TrackingPage.new,
    'history': HistoryPage.new,
    'plan': PlanPage.new,
    'settings': () => BlocProvider.value(
      value: settingsCubit,
      child: const SettingsPage(),
    ),
  };

  for (final entry in screens.entries) {
    for (final variant in AppThemeVariant.values) {
      testWidgets(
        '${entry.key} matches the ${variant.name} golden',
        (tester) async {
          await pumpThemed(tester, entry.value(), variant: variant);

          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile('${entry.key}_${variant.name}.png'),
          );
        },
        skip: !_runGoldens,
      );
    }
  }
}
