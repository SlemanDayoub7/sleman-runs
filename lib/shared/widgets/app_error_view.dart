import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/l10n/failure_messages.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/core/error/failure.dart';
import 'package:sleman_runs/shared/widgets/app_button.dart';
import 'package:sleman_runs/shared/widgets/app_empty_state.dart';

/// Failure view that maps a domain [Failure] to localised copy.
///
/// Presentation passes a failure, not a string, so no screen invents its own
/// error wording and every failure code has exactly one message.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    required this.failure,
    required this.onRetry,
    this.title,
    super.key,
  });

  final Failure failure;
  final VoidCallback onRetry;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppEmptyState(
      icon: Icons.error_outline,
      tone: AppTone.error,
      title: title ?? l10n.errorTitle,
      message: l10n.messageFor(failure.code),
      action: AppButton(
        label: l10n.commonRetry,
        icon: Icons.refresh,
        variant: AppButtonVariant.outlined,
        onPressed: onRetry,
      ),
    );
  }
}
