import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/app/theme/tokens/app_radii.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';
import 'package:sleman_runs/shared/widgets/app_icon.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

/// Small status label: PR, GPS lock, offline, plan week.
///
/// Meaning is carried by the text, never by colour alone.
class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    this.tone = AppTone.primary,
    this.icon,
    super.key,
  });

  final String label;
  final AppTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final foreground = tone.color(context.appColors);
    final icon = this.icon;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: foreground.withValues(alpha: 0.12),
        borderRadius: AppRadii.pillAll,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              AppIcon(icon, size: AppSizes.iconSmall, tone: tone),
              const SizedBox(width: AppSpacing.xxs),
            ],
            AppText(label, role: AppTextRole.caption, tone: tone),
          ],
        ),
      ),
    );
  }
}
