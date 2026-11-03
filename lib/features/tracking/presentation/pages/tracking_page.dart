import 'package:flutter/material.dart';
import 'package:sleman_runs/app/l10n/generated/app_localizations.dart';
import 'package:sleman_runs/shared/widgets/placeholder_page.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return PlaceholderPage(
      title: l10n.trackTitle,
      message: l10n.trackPlaceholder,
      icon: Icons.play_circle_outline,
    );
  }
}
