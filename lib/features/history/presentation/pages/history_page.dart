import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/shared/widgets/app_empty_state.dart';
import 'package:sleman_runs/shared/widgets/app_scaffold.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppScaffold(
      appBar: AppBar(
        title: AppText(l10n.navHistory, role: AppTextRole.h3),
      ),
      body: AppEmptyState(
        icon: Icons.route_outlined,
        title: l10n.historyEmptyTitle,
        message: l10n.historyEmptyBody,
      ),
    );
  }
}
