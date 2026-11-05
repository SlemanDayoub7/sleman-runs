import 'package:flutter/material.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';
import 'package:sleman_runs/shared/widgets/app_text.dart';

/// Section title with an optional trailing action.
class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    required this.title,
    this.trailing,
    this.padding = const EdgeInsetsDirectional.only(bottom: AppSpacing.sm),
    super.key,
  });

  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          Expanded(child: AppText(title, role: AppTextRole.h3)),
          ?trailing,
        ],
      ),
    );
  }
}
