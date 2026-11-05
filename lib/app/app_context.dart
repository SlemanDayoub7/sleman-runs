import 'package:flutter/material.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/app/responsive/app_window_class.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/pace_colors.dart';

/// The single door to theme, text and localisation tokens.
///
/// Feature code reads `context.appColors`, never
/// `Theme.of(context).extension<AppColors>()`. That keeps the token type out of
/// the widget tree and makes a token rename a single-file change.
extension AppContextX on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  PaceColors get paceColors => Theme.of(this).extension<PaceColors>()!;

  TextTheme get textTheme => Theme.of(this).textTheme;

  AppLocalizations get l10n => AppLocalizations.of(this);

  AppWindowClass get window {
    return AppWindowClass.fromWidth(MediaQuery.sizeOf(this).width);
  }

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}
