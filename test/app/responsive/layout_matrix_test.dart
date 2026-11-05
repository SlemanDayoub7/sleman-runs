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
import 'package:sleman_runs/shared/widgets/app_scaffold.dart';

import '../../support/fake_settings_repository.dart';
import '../../support/pump_themed.dart';

/// Widths that matter: the smallest Android phone we support, the Pixel-class
/// design phone, and the Material expanded breakpoint.
const _widths = <double>[320, 412, 840];

/// Text scales the OS can ask for. 2.0 is the WCAG reflow stress case.
const _textScales = <double>[1, 2];

void main() {
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
    testWidgets('${entry.key} lays out at every width, scale and theme', (
      tester,
    ) async {
      for (final variant in AppThemeVariant.values) {
        for (final width in _widths) {
          for (final scale in _textScales) {
            final reason =
                '${entry.key} ${variant.name} ${width.toInt()}dp x$scale';

            await pumpThemed(
              tester,
              entry.value(),
              variant: variant,
              size: Size(width, 900),
              textScale: scale,
            );

            expect(tester.takeException(), isNull, reason: reason);

            final context = tester.element(find.byType(AppScaffold));
            expect(
              Directionality.of(context),
              variant.isArabic ? TextDirection.rtl : TextDirection.ltr,
              reason: reason,
            );
            expect(
              Theme.of(context).brightness,
              variant.brightness,
              reason: reason,
            );
          }
        }
      }
    });
  }
}
