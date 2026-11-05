import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_state.dart';
import 'package:sleman_runs/shared/widgets/app_card.dart';
import 'package:sleman_runs/shared/widgets/app_choice_chip.dart';
import 'package:sleman_runs/shared/widgets/app_scaffold.dart';
import 'package:sleman_runs/shared/widgets/app_section_header.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

/// Theme and language controls. This is the screen that proves the design
/// system and localisation work end to end.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final settings = context.watch<SettingsCubit>().state.currentSettings;
    final cubit = context.read<SettingsCubit>();

    return AppScaffold(
      appBar: AppBar(
        title: AppText(l10n.settingsTitle, role: AppTextRole.h3),
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.only(
          top: AppSpacing.xs,
          bottom: AppSpacing.xxl,
        ),
        children: [
          AppSectionHeader(title: l10n.settingsAppearance),
          AppCard(
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final mode in AppThemeMode.values)
                  AppChoiceChip(
                    label: _themeLabel(l10n, mode),
                    icon: _themeIcon(mode),
                    selected: settings.themeMode == mode,
                    onSelected: (_) {
                      unawaited(cubit.setThemeMode(mode));
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppSectionHeader(title: l10n.settingsLanguage),
          AppCard(
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final language in AppLanguage.values)
                  AppChoiceChip(
                    label: _languageLabel(l10n, language),
                    selected: settings.language == language,
                    onSelected: (_) {
                      unawaited(cubit.setLanguage(language));
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppText(
            l10n.appTagline,
            role: AppTextRole.caption,
            tone: AppTone.secondary,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _themeLabel(AppLocalizations l10n, AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => l10n.themeSystem,
      AppThemeMode.light => l10n.themeLight,
      AppThemeMode.dark => l10n.themeDark,
    };
  }

  IconData _themeIcon(AppThemeMode mode) {
    return switch (mode) {
      AppThemeMode.system => Icons.brightness_auto_outlined,
      AppThemeMode.light => Icons.light_mode_outlined,
      AppThemeMode.dark => Icons.dark_mode_outlined,
    };
  }

  String _languageLabel(AppLocalizations l10n, AppLanguage language) {
    return switch (language) {
      AppLanguage.system => l10n.languageSystem,
      AppLanguage.english => l10n.languageEnglish,
      AppLanguage.arabic => l10n.languageArabic,
    };
  }
}
