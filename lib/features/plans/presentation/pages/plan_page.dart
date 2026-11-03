import 'package:flutter/material.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/shared/widgets/placeholder_page.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PlaceholderPage(
      title: l10n.planTitle,
      message: l10n.planEmptyBody,
      icon: Icons.calendar_month_outlined,
    );
  }
}
