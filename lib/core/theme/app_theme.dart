import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'component_themes/appbar_theme.dart';
import 'component_themes/button_theme.dart';
import 'component_themes/card_theme.dart';
import 'component_themes/input_theme.dart';
import 'component_themes/navigation_theme.dart';

class AppTheme {
  // Light Theme Configuration
  static ThemeData get lightTheme {
    return ThemeData(
      // Material 3 design system
      useMaterial3: true,
      
      // Color scheme
      colorScheme: AppColors.lightColorScheme,
      
      // Typography
      textTheme: AppTextStyles.lightTextTheme,
      
      // Primary swatch for backwards compatibility
      primarySwatch: _createMaterialColor(AppColors.primaryTeal),
      
      // Visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,
      
      // Component themes
      appBarTheme: AppBarThemeConfig.lightAppBarTheme,
      elevatedButtonTheme: AppButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: AppButtonTheme.lightOutlinedButtonTheme,
      textButtonTheme: AppButtonTheme.lightTextButtonTheme,
      floatingActionButtonTheme: AppButtonTheme.lightFabTheme,
      cardTheme: AppCardTheme.lightCardTheme,
      inputDecorationTheme: AppInputTheme.lightInputDecorationTheme,
      bottomNavigationBarTheme: AppNavigationTheme.lightBottomNavigationBarTheme,
      drawerTheme: AppNavigationTheme.lightDrawerTheme,
      navigationRailTheme: AppNavigationTheme.lightNavigationRailTheme,
      tabBarTheme: AppNavigationTheme.lightTabBarTheme,
      
      // Additional component themes
      scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
      canvasColor: AppColors.lightColorScheme.surface,
      dividerColor: AppColors.lightColorScheme.outline.withValues(alpha: 0.2),
      
      // Icon theme
      iconTheme: IconThemeData(
        color: AppColors.lightColorScheme.onSurface,
        size: 24,
      ),
      primaryIconTheme: IconThemeData(
        color: AppColors.lightColorScheme.onPrimary,
        size: 24,
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryTeal;
          }
          return null;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryTeal;
          }
          return AppColors.gray400;
        }),
      ),
      
      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryTeal;
          }
          return AppColors.gray300;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryTeal.withValues(alpha: 0.5);
          }
          return AppColors.gray200;
        }),
      ),
      
      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryTeal,
        inactiveTrackColor: AppColors.gray300,
        thumbColor: AppColors.primaryTeal,
        overlayColor: AppColors.primaryTeal.withValues(alpha: 0.2),
        valueIndicatorColor: AppColors.primaryTeal,
        valueIndicatorTextStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.white,
        ),
      ),
      
      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryTeal,
        linearTrackColor: AppColors.gray200,
        circularTrackColor: AppColors.gray200,
      ),
      
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray100,
        deleteIconColor: AppColors.gray600,
        disabledColor: AppColors.gray50,
        selectedColor: AppColors.primaryTeal.withValues(alpha: 0.2),
        secondarySelectedColor: AppColors.secondaryGreen.withValues(alpha: 0.2),
        labelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.gray800,
        ),
        secondaryLabelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.gray800,
        ),
        brightness: Brightness.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Tooltip theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.gray800,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.gray800,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.white,
        ),
        actionTextColor: AppColors.primaryTealLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 24,
        shadowColor: AppColors.shadowMedium,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.gray900,
        ),
        contentTextStyle: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.gray700,
        ),
      ),
      
      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 16,
        shadowColor: AppColors.shadowMedium,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  // Dark Theme Configuration
  static ThemeData get darkTheme {
    return ThemeData(
      // Material 3 design system
      useMaterial3: true,
      
      // Color scheme
      colorScheme: AppColors.darkColorScheme,
      
      // Typography
      textTheme: AppTextStyles.darkTextTheme,
      
      // Primary swatch for backwards compatibility
      primarySwatch: _createMaterialColor(AppColors.primaryTeal),
      
      // Visual density
      visualDensity: VisualDensity.adaptivePlatformDensity,
      
      // Component themes
      appBarTheme: AppBarThemeConfig.darkAppBarTheme,
      elevatedButtonTheme: AppButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: AppButtonTheme.darkOutlinedButtonTheme,
      textButtonTheme: AppButtonTheme.darkTextButtonTheme,
      floatingActionButtonTheme: AppButtonTheme.darkFabTheme,
      cardTheme: AppCardTheme.darkCardTheme,
      inputDecorationTheme: AppInputTheme.darkInputDecorationTheme,
      bottomNavigationBarTheme: AppNavigationTheme.darkBottomNavigationBarTheme,
      drawerTheme: AppNavigationTheme.darkDrawerTheme,
      navigationRailTheme: AppNavigationTheme.darkNavigationRailTheme,
      tabBarTheme: AppNavigationTheme.darkTabBarTheme,
      
      // Additional component themes
      scaffoldBackgroundColor: AppColors.darkColorScheme.surface,
      canvasColor: AppColors.darkColorScheme.surface,
      dividerColor: AppColors.darkColorScheme.outline.withValues(alpha: 0.2),
      
      // Icon theme
      iconTheme: IconThemeData(
        color: AppColors.darkColorScheme.onSurface,
        size: 24,
      ),
      primaryIconTheme: IconThemeData(
        color: AppColors.darkColorScheme.onPrimary,
        size: 24,
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkColorScheme.primary;
          }
          return null;
        }),
        checkColor: WidgetStateProperty.all(AppColors.darkColorScheme.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkColorScheme.primary;
          }
          return AppColors.darkColorScheme.onSurfaceVariant;
        }),
      ),
      
      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkColorScheme.primary;
          }
          return AppColors.darkColorScheme.outline;
        }),
        trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.darkColorScheme.primary.withValues(alpha: 0.5);
          }
          return AppColors.darkColorScheme.surfaceContainerHighest;
        }),
      ),
      
      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.darkColorScheme.primary,
        inactiveTrackColor: AppColors.darkColorScheme.outline,
        thumbColor: AppColors.darkColorScheme.primary,
        overlayColor: AppColors.darkColorScheme.primary.withValues(alpha: 0.2),
        valueIndicatorColor: AppColors.darkColorScheme.primary,
        valueIndicatorTextStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkColorScheme.onPrimary,
        ),
      ),
      
      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.darkColorScheme.primary,
        linearTrackColor: AppColors.darkColorScheme.surfaceContainerHighest,
        circularTrackColor: AppColors.darkColorScheme.surfaceContainerHighest,
      ),
      
      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkColorScheme.surfaceContainerHighest,
        deleteIconColor: AppColors.darkColorScheme.onSurfaceVariant,
        disabledColor: AppColors.darkColorScheme.surface,
        selectedColor: AppColors.darkColorScheme.primary.withValues(alpha: 0.2),
        secondarySelectedColor: AppColors.darkColorScheme.secondary.withValues(alpha: 0.2),
        labelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkColorScheme.onSurfaceVariant,
        ),
        secondaryLabelStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkColorScheme.onSurfaceVariant,
        ),
        brightness: Brightness.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Tooltip theme
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.darkColorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkColorScheme.onInverseSurface,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.darkColorScheme.inverseSurface,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkColorScheme.onInverseSurface,
        ),
        actionTextColor: AppColors.darkColorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.darkColorScheme.surface,
        surfaceTintColor: AppColors.darkColorScheme.surface,
        elevation: 24,
        shadowColor: AppColors.shadowDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        titleTextStyle: AppTextStyles.headlineSmall.copyWith(
          color: AppColors.darkColorScheme.onSurface,
        ),
        contentTextStyle: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.darkColorScheme.onSurface,
        ),
      ),
      
      // Bottom sheet theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.darkColorScheme.surface,
        surfaceTintColor: AppColors.darkColorScheme.surface,
        elevation: 16,
        shadowColor: AppColors.shadowDark,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  // Helper method to create MaterialColor for backwards compatibility
  static MaterialColor _createMaterialColor(Color color) {
    final strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = (color.r * 255.0).round() & 0xff;
    final int g = (color.g * 255.0).round() & 0xff;
    final int b = (color.b * 255.0).round() & 0xff;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.toARGB32(), swatch);
  }
}