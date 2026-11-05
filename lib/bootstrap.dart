import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:sleman_runs/app/app.dart';
import 'package:sleman_runs/app/di/injection.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';

/// Composition root: build the graph, load persisted state, then show UI.
///
/// Settings are awaited before `runApp` so the first frame already has the
/// correct theme, locale and text direction — no flash of the wrong mode.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Phones are portrait-only. Android 16 ignores this on displays >= 600 dp,
  // which is why every screen also has to be width-responsive.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await configureDependencies();

  final settingsCubit = getIt<SettingsCubit>();
  await settingsCubit.load();

  runApp(
    SlemanRunsApp(
      router: getIt<GoRouter>(),
      settingsCubit: settingsCubit,
    ),
  );
}
