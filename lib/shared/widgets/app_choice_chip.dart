import 'package:flutter/material.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';

/// A themed, wrapping single-choice chip.
///
/// Used instead of a horizontal segmented control so three options survive
/// 200% text scaling and Arabic on a 320 dp screen.
class AppChoiceChip extends StatelessWidget {
  const AppChoiceChip({
    required this.label,
    required this.selected,
    required this.onSelected,
    this.icon,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      avatar: icon == null ? null : Icon(icon, size: AppSizes.iconSmall),
    );
  }
}
