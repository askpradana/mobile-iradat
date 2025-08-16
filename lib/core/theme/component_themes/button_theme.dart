import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppButtonTheme {
  // Light Theme Button Configurations
  static ElevatedButtonThemeData lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryTeal,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.gray300,
      disabledForegroundColor: AppColors.gray600,
      shadowColor: AppColors.shadowLight,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.white,
      ),
    ),
  );

  static OutlinedButtonThemeData lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryTeal,
      disabledForegroundColor: AppColors.gray400,
      side: const BorderSide(
        color: AppColors.primaryTeal,
        width: 1.5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.primaryTeal,
      ),
    ),
  );

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryTeal,
      disabledForegroundColor: AppColors.gray400,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.primaryTeal,
        fontWeight: AppTextStyles.medium,
      ),
    ),
  );

  static FloatingActionButtonThemeData lightFabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryTeal,
    foregroundColor: AppColors.white,
    elevation: 4,
    focusElevation: 6,
    hoverElevation: 6,
    highlightElevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  // Dark Theme Button Configurations
  static ElevatedButtonThemeData darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkColorScheme.primary,
      foregroundColor: AppColors.darkColorScheme.onPrimary,
      disabledBackgroundColor: AppColors.darkColorScheme.surfaceContainerHighest,
      disabledForegroundColor: AppColors.darkColorScheme.onSurfaceVariant.withValues(alpha: 0.4),
      shadowColor: AppColors.shadowMedium,
      elevation: 2,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.darkColorScheme.onPrimary,
      ),
    ),
  );

  static OutlinedButtonThemeData darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.darkColorScheme.primary,
      disabledForegroundColor: AppColors.darkColorScheme.onSurfaceVariant.withValues(alpha: 0.4),
      side: BorderSide(
        color: AppColors.darkColorScheme.primary,
        width: 1.5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.darkColorScheme.primary,
      ),
    ),
  );

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.darkColorScheme.primary,
      disabledForegroundColor: AppColors.darkColorScheme.onSurfaceVariant.withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        color: AppColors.darkColorScheme.primary,
        fontWeight: AppTextStyles.medium,
      ),
    ),
  );

  static FloatingActionButtonThemeData darkFabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.darkColorScheme.primary,
    foregroundColor: AppColors.darkColorScheme.onPrimary,
    elevation: 4,
    focusElevation: 6,
    hoverElevation: 6,
    highlightElevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );

  // Custom Button Styles
  static ButtonStyle primaryButtonStyle({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: isDark 
        ? AppColors.darkColorScheme.primary 
        : AppColors.primaryTeal,
      foregroundColor: isDark 
        ? AppColors.darkColorScheme.onPrimary 
        : AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      textStyle: AppTextStyles.buttonText,
    );
  }

  static ButtonStyle secondaryButtonStyle({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: isDark 
        ? AppColors.darkColorScheme.secondary 
        : AppColors.secondaryGreen,
      foregroundColor: isDark 
        ? AppColors.darkColorScheme.onSecondary 
        : AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      textStyle: AppTextStyles.buttonText,
    );
  }

  static ButtonStyle dangerButtonStyle({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.error,
      foregroundColor: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      textStyle: AppTextStyles.buttonText,
    );
  }

  static ButtonStyle successButtonStyle({bool isDark = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppColors.success,
      foregroundColor: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      textStyle: AppTextStyles.buttonText,
    );
  }

  static ButtonStyle ghostButtonStyle({bool isDark = false}) {
    return TextButton.styleFrom(
      foregroundColor: isDark 
        ? AppColors.darkColorScheme.primary 
        : AppColors.primaryTeal,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide.none,
      ),
      textStyle: AppTextStyles.buttonText.copyWith(
        fontWeight: AppTextStyles.medium,
      ),
    );
  }
}