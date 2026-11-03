import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/features/settings/domain/entities/app_settings.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:sleman_runs/features/settings/presentation/cubit/settings_state.dart';

/// Theme and language controls. This is the screen that proves the design
/// system and localisation work end to end.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppColors>()!;
    final settings = context.watch<SettingsCubit>().state.currentSettings;
    final cubit = context.read<SettingsCubit>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _SectionLabel(text: l10n.settingsAppearance),
          SegmentedButton<AppThemeMode>(
            segments: [
              ButtonSegment(
                value: AppThemeMode.system,
                icon: const Icon(Icons.brightness_auto_outlined),
                label: Text(l10n.themeSystem),
              ),
              ButtonSegment(
                value: AppThemeMode.light,
                icon: const Icon(Icons.light_mode_outlined),
                label: Text(l10n.themeLight),
              ),
              ButtonSegment(
                value: AppThemeMode.dark,
                icon: const Icon(Icons.dark_mode_outlined),
                label: Text(l10n.themeDark),
              ),
            ],
            selected: {settings.themeMode},
            showSelectedIcon: false,
            onSelectionChanged: (selection) {
              unawaited(cubit.setThemeMode(selection.first));
            },
          ),
          const SizedBox(height: 28),
          _SectionLabel(text: l10n.settingsLanguage),
          SegmentedButton<AppLanguage>(
            segments: [
              ButtonSegment(
                value: AppLanguage.system,
                icon: const Icon(Icons.translate),
                label: Text(l10n.languageSystem),
              ),
              ButtonSegment(
                value: AppLanguage.english,
                label: Text(l10n.languageEnglish),
              ),
              ButtonSegment(
                value: AppLanguage.arabic,
                label: Text(l10n.languageArabic),
              ),
            ],
            selected: {settings.language},
            showSelectedIcon: false,
            onSelectionChanged: (selection) {
              unawaited(cubit.setLanguage(selection.first));
            },
          ),
          const SizedBox(height: 40),
          Text(
            l10n.appTagline,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.labelLarge?.copyWith(color: colors.textSecondary),
      ),
    );
  }
}
