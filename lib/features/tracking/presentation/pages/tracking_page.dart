import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/shared/widgets/app_empty_state.dart';
import 'package:sleman_runs/shared/widgets/app_scaffold.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppScaffold(
      appBar: AppBar(
        title: AppText(l10n.navTrack, role: AppTextRole.h3),
      ),
      body: AppEmptyState(
        icon: Icons.play_circle_outline,
        title: l10n.trackTitle,
        message: l10n.trackPlaceholder,
      ),
    );
  }
}
