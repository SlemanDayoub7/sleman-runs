import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';

/// Visual variants that map to Material buttons.
enum AppButtonVariant { filled, outlined, text }

/// Button wrapper for two cases Material does not handle well: an async
/// loading state and a full-width call to action.
///
/// Everything else should use the globally themed Filled/Outlined/TextButton.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !isLoading;
    final effectiveOnPressed = enabled ? onPressed : null;
    final progressColor = variant == AppButtonVariant.filled
        ? context.appColors.onPrimary
        : context.appColors.primary;

    final child = isLoading
        ? SizedBox.square(
            dimension: AppSizes.iconSmall,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: progressColor,
            ),
          )
        : icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: AppSizes.iconSmall),
              const SizedBox(width: AppSpacing.xs),
              Flexible(child: Text(label)),
            ],
          );

    final button = switch (variant) {
      AppButtonVariant.filled => FilledButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonVariant.outlined => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
      AppButtonVariant.text => TextButton(
        onPressed: effectiveOnPressed,
        child: child,
      ),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
