import 'package:flutter/material.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/shared/widgets/placeholder_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PlaceholderPage(
      title: l10n.historyTitle,
      message: l10n.historyEmptyBody,
      icon: Icons.route_outlined,
    );
  }
}
