import 'package:flutter/material.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

/// A label and a tabular value that stays left-to-right in every locale.
///
/// The live distance and timer are wrapped in a repaint boundary so a ticking
/// number does not invalidate the rest of the screen.
class AppMetric extends StatelessWidget {
  const AppMetric({
    required this.value,
    this.unit,
    this.label,
    this.role = AppTextRole.metric,
    super.key,
  });

  final String value;
  final String? unit;
  final String? label;
  final AppTextRole role;

  @override
  Widget build(BuildContext context) {
    final unit = this.unit;
    final label = this.label;
    final semantics = [label, value, unit].whereType<String>().join(' ');

    return Semantics(
      label: semantics,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            AppText(label, role: AppTextRole.caption),
            const SizedBox(height: AppSpacing.xxs),
          ],
          RepaintBoundary(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AppText(value, role: role),
                  if (unit != null) ...[
                    const SizedBox(width: AppSpacing.xxs),
                    AppText(unit, role: AppTextRole.caption),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
