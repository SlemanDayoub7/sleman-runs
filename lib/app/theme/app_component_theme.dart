import 'package:flutter/material.dart';
import 'package:sleman_runs/app/theme/app_colors.dart';
import 'package:sleman_runs/app/theme/app_text_styles.dart';
import 'package:sleman_runs/app/theme/tokens/app_radii.dart';
import 'package:sleman_runs/app/theme/tokens/app_sizes.dart';
import 'package:sleman_runs/app/theme/tokens/app_spacing.dart';

/// Applies one consistent component language to every Material widget.
///
/// Wrapping widgets is a performance tax and a maintenance cost. Theming them
/// once here means screens use standard Material controls and still look
/// like the product.
ThemeData applyAppComponentThemes({
  required ThemeData base,
  required AppColors colors,
  required TextTheme textTheme,
  required Brightness brightness,
}) {
  return base.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      surfaceTintColor: Colors.transparent,
      foregroundColor: colors.textPrimary,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleSpacing: AppSpacing.gutter,
      titleTextStyle: textTheme.h3,
      iconTheme: IconThemeData(color: colors.textPrimary),
    ),
    iconTheme: IconThemeData(
      color: colors.textSecondary,
      size: AppSizes.icon,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        minimumSize: const Size.square(AppSizes.minTapTarget),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        disabledBackgroundColor: colors.surfaceVariant,
        disabledForegroundColor: colors.textSecondary,
        minimumSize: const Size(64, AppSizes.minTapTarget),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        shape: const StadiumBorder(),
        textStyle: textTheme.label,
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.primary,
        disabledForegroundColor: colors.textSecondary,
        minimumSize: const Size(64, AppSizes.minTapTarget),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        side: BorderSide(color: colors.outline),
        shape: const StadiumBorder(),
        textStyle: textTheme.label,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.primary,
        disabledForegroundColor: colors.textSecondary,
        minimumSize: const Size(48, AppSizes.minTapTarget),
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: const StadiumBorder(),
        textStyle: textTheme.label,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: colors.primaryContainer,
      indicatorShape: const StadiumBorder(),
      elevation: 0,
      height: 80,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return textTheme.labelMedium?.copyWith(
          color: selected ? colors.primary : colors.textSecondary,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? colors.primary : colors.textSecondary,
          size: AppSizes.icon,
        );
      }),
    ),
    cardTheme: CardThemeData(
      color: colors.surface,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.cardAll,
        side: BorderSide(color: colors.outline),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: colors.surfaceVariant,
      selectedColor: colors.primaryContainer,
      disabledColor: colors.surfaceVariant,
      checkmarkColor: colors.primary,
      labelStyle: textTheme.label.copyWith(color: colors.textPrimary),
      secondaryLabelStyle: textTheme.label.copyWith(color: colors.textPrimary),
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      labelPadding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.xxs,
      ),
      shape: const StadiumBorder(),
      side: BorderSide.none,
      elevation: 0,
      pressElevation: 0,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: colors.textSecondary,
        size: AppSizes.iconSmall,
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: colors.surfaceVariant,
      contentPadding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(color: colors.textSecondary),
      labelStyle: textTheme.labelMedium?.copyWith(
        color: colors.textSecondary,
      ),
      floatingLabelStyle: textTheme.labelMedium?.copyWith(
        color: colors.primary,
      ),
      errorStyle: textTheme.caption.copyWith(color: colors.error),
      border: OutlineInputBorder(
        borderRadius: AppRadii.inputAll,
        borderSide: BorderSide(color: colors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadii.inputAll,
        borderSide: BorderSide(color: colors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadii.inputAll,
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadii.inputAll,
        borderSide: BorderSide(color: colors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadii.inputAll,
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(
          Size(48, AppSizes.minTapTarget),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
        ),
        textStyle: WidgetStatePropertyAll(textTheme.label),
        shape: const WidgetStatePropertyAll(StadiumBorder()),
        side: WidgetStatePropertyAll(BorderSide(color: colors.outline)),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colors.primaryContainer;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return colors.textSecondary;
          }
          if (states.contains(WidgetState.selected)) {
            return colors.primary;
          }
          return colors.textPrimary;
        }),
      ),
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xxs,
      ),
      iconColor: colors.textSecondary,
      textColor: colors.textPrimary,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.inputAll),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colors.onPrimary;
        }
        return colors.surface;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colors.primary;
        }
        return colors.surfaceVariant;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.transparent;
        }
        return colors.outline;
      }),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: colors.primary,
      linearTrackColor: colors.surfaceVariant,
      circularTrackColor: colors.surfaceVariant,
    ),
    dividerTheme: DividerThemeData(
      color: colors.outline,
      thickness: AppSizes.border,
      space: AppSizes.border,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.sheetAll),
      titleTextStyle: textTheme.h3,
      contentTextStyle: textTheme.body,
      iconColor: colors.textSecondary,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: colors.surface,
      modalBackgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      modalElevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: AppRadii.sheetTop,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: colors.textPrimary,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colors.background,
      ),
      actionTextColor: colors.primary,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      shape: const RoundedRectangleBorder(borderRadius: AppRadii.inputAll),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: colors.primary,
      unselectedLabelColor: colors.textSecondary,
      indicatorColor: colors.primary,
      dividerColor: colors.outline,
      labelStyle: textTheme.label,
      unselectedLabelStyle: textTheme.label,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: colors.textPrimary,
        borderRadius: AppRadii.inputAll,
      ),
      textStyle: textTheme.caption.copyWith(color: colors.background),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: colors.primary,
      selectionColor: colors.primaryContainer,
      selectionHandleColor: colors.primary,
    ),
  );
}
