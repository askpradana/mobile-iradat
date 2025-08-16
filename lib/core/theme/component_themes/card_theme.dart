import 'package:flutter/material.dart';
import '../app_colors.dart';

class AppCardTheme {
  // Light Theme Card Configuration
  static CardThemeData lightCardTheme = CardThemeData(
    elevation: 2,
    shadowColor: AppColors.shadowLight,
    surfaceTintColor: AppColors.white,
    color: AppColors.white,
    margin: const EdgeInsets.symmetric(vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    clipBehavior: Clip.antiAlias,
  );

  // Dark Theme Card Configuration
  static CardThemeData darkCardTheme = CardThemeData(
    elevation: 2,
    shadowColor: AppColors.shadowMedium,
    surfaceTintColor: AppColors.darkColorScheme.surface,
    color: AppColors.darkColorScheme.surface,
    margin: const EdgeInsets.symmetric(vertical: 4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    clipBehavior: Clip.antiAlias,
  );

  // Assessment Card Styles
  static BoxDecoration assessmentCardDecoration(Color color, {bool isDark = false}) {
    return BoxDecoration(
      color: isDark ? AppColors.darkColorScheme.surface : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: color.withValues(alpha: 0.2),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? AppColors.shadowMedium : AppColors.shadowLight,
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Quick Action Card Styles
  static BoxDecoration quickActionCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      color: isDark ? AppColors.darkColorScheme.surface : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark 
          ? AppColors.darkColorScheme.outline.withValues(alpha: 0.3)
          : AppColors.lightColorScheme.outline.withValues(alpha: 0.2),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? AppColors.shadowMedium : AppColors.shadowLight,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  // Settings Card Styles
  static BoxDecoration settingsCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      color: isDark ? AppColors.darkColorScheme.surface : AppColors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: isDark 
          ? AppColors.darkColorScheme.outline.withValues(alpha: 0.2)
          : AppColors.lightColorScheme.outline.withValues(alpha: 0.15),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? AppColors.shadowLight : AppColors.shadowLight,
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  // Profile Card Styles
  static BoxDecoration profileCardDecoration({bool isDark = false}) {
    return BoxDecoration(
      gradient: isDark 
        ? LinearGradient(
            colors: [
              AppColors.darkColorScheme.primaryContainer,
              AppColors.darkColorScheme.primary.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : LinearGradient(
            colors: [
              AppColors.lightColorScheme.primaryContainer,
              AppColors.lightColorScheme.primary.withValues(alpha: 0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: isDark ? AppColors.shadowMedium : AppColors.shadowLight,
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  // Result Card Styles
  static BoxDecoration resultCardDecoration({
    required Color color,
    bool isDark = false,
  }) {
    return BoxDecoration(
      color: isDark ? AppColors.darkColorScheme.surface : AppColors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: color.withValues(alpha: 0.3),
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: isDark ? 0.2 : 0.1),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}