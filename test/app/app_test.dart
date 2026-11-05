import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sleman_runs/app/app.dart';
import 'package:sleman_runs/app/di/injection.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sleman_runs/features/settings/presentation/pages/settings_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await getIt.reset();
    SharedPreferences.setMockInitialValues({});
    await configureDependencies();
  });

  tearDown(() async {
    await getIt.reset();
  });

  /// Boots the real widget tree: theme, localisation delegates, router and
  /// navigation shell. Only storage is faked, so the test exercises the same
  /// wiring the app uses at runtime.
  Future<void> pumpApp(
    WidgetTester tester, {
    AppLanguage language = AppLanguage.english,
  }) async {
    final settingsCubit = getIt<SettingsCubit>();
    await settingsCubit.setLanguage(language);

    await tester.pumpWidget(
      SlemanRunsApp(
        router: getIt<GoRouter>(),
        settingsCubit: settingsCubit,
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Scoped to the navigation bar: a tab label and an app bar title can share
  /// the same word, so an unscoped `find.text` would be ambiguous.
  Finder navLabel(String label) {
    return find.descendant(
      of: find.byType(NavigationBar),
      matching: find.text(label),
    );
  }

  testWidgets('renders all four navigation destinations in English', (
    tester,
  ) async {
    await pumpApp(tester);

    expect(navLabel('Track'), findsOneWidget);
    expect(navLabel('History'), findsOneWidget);
    expect(navLabel('Plan'), findsOneWidget);
    expect(navLabel('Settings'), findsOneWidget);
  });

  testWidgets('starts on the tracking tab', (tester) async {
    await pumpApp(tester);

    expect(find.text('Ready to run'), findsOneWidget);
    expect(navLabel('Track'), findsOneWidget);
  });

  testWidgets('switches to Arabic and lays the shell out right to left', (
    tester,
  ) async {
    await pumpApp(tester, language: AppLanguage.arabic);

    expect(navLabel('الجري'), findsOneWidget);
    expect(navLabel('السجل'), findsOneWidget);
    expect(navLabel('الخطة'), findsOneWidget);
    expect(navLabel('الإعدادات'), findsOneWidget);

    final shellContext = tester.element(find.byType(NavigationBar));
    expect(Directionality.of(shellContext), TextDirection.rtl);
  });

  testWidgets('honours the persisted dark theme', (tester) async {
    final settingsCubit = getIt<SettingsCubit>();
    await settingsCubit.setThemeMode(AppThemeMode.dark);
    await tester.pumpWidget(
      SlemanRunsApp(
        router: getIt<GoRouter>(),
        settingsCubit: settingsCubit,
      ),
    );
    await tester.pumpAndSettle();

    final scaffoldContext = tester.element(find.byType(Scaffold).first);
    expect(Theme.of(scaffoldContext).brightness, Brightness.dark);
  });

  testWidgets('navigates to settings from the bottom bar', (tester) async {
    await pumpApp(tester);

    await tester.tap(navLabel('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
  });
}
