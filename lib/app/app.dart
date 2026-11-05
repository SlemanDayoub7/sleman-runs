import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sleman_runs/app/app_mappings.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/app/theme/app_theme.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_state.dart';

/// Root widget: theme, locale and router, driven by one settings state.
class SlemanRunsApp extends StatelessWidget {
  const SlemanRunsApp({
    required this.router,
    required this.settingsCubit,
    super.key,
  });

  final GoRouter router;
  final SettingsCubit settingsCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final settings = state.currentSettings;
          final arabic = _isArabic(settings.language);

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.forLocale(
              brightness: Brightness.light,
              arabic: arabic,
            ),
            darkTheme: AppTheme.forLocale(
              brightness: Brightness.dark,
              arabic: arabic,
            ),
            themeMode: settings.themeMode.material,
            locale: settings.language.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            onGenerateTitle: (context) {
              return AppLocalizations.of(context).appName;
            },
            routerConfig: router,
          );
        },
      ),
    );
  }

  static bool _isArabic(AppLanguage language) {
    return switch (language) {
      AppLanguage.arabic => true,
      AppLanguage.english => false,
      AppLanguage.system =>
        basicLocaleListResolution(
              WidgetsBinding.instance.platformDispatcher.locales,
              AppLocalizations.supportedLocales,
            ).languageCode ==
            'ar',
    };
  }
}
