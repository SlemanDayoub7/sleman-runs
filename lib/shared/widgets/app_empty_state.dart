import 'package:flutter/material.dart';
import 'package:sleman_runs/app/app_context.dart';
import 'package:sleman_runs/app/theme/app_tone.dart';
import 'package:sleman_runs/app/theme/tokens/app_radii.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';
import 'package:sleman_runs/shared/widgets/app_icon.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

/// Empty state with one optional action.
///
/// Scrollable and height-aware so 200% text scaling cannot clip the copy on a
/// 320 dp screen.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    required this.icon,
    required this.title,
    this.message,
    this.action,
    this.tone = AppTone.primary,
    super.key,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;
  final AppTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final accent = tone.color(colors);
    final artworkColor = tone == AppTone.primary
        ? colors.primaryContainer
        : accent.withValues(alpha: 0.12);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: AppSizes.emptyArtwork,
                      height: AppSizes.emptyArtwork,
                      decoration: BoxDecoration(
                        color: artworkColor,
                        borderRadius: AppRadii.cardAll,
                      ),
                      child: Center(
                        child: AppIcon(
                          icon,
                          size: AppSizes.iconLarge,
                          tone: tone,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppText(
                      title,
                      role: AppTextRole.h2,
                      textAlign: TextAlign.center,
                    ),
                    if (message != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      AppText(
                        message!,
                        tone: AppTone.secondary,
                        textAlign: TextAlign.center,
                      ),
                    ],
                    if (action != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      action!,
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
