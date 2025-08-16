import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppInputTheme {
  // Light Theme Input Field Configuration
  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.gray50,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    
    // Border configurations
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.gray300,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.gray300,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.primaryTeal,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.error,
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.error,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.gray200,
        width: 1,
      ),
    ),
    
    // Label and hint styles
    labelStyle: AppTextStyles.formLabel.copyWith(
      color: AppColors.gray700,
    ),
    floatingLabelStyle: AppTextStyles.formLabel.copyWith(
      color: AppColors.primaryTeal,
    ),
    hintStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.gray500,
    ),
    helperStyle: AppTextStyles.bodySmall.copyWith(
      color: AppColors.gray600,
    ),
    errorStyle: AppTextStyles.formError.copyWith(
      color: AppColors.error,
    ),
    
    // Icon configuration
    prefixIconColor: AppColors.gray600,
    suffixIconColor: AppColors.gray600,
    
    // Constraints
    constraints: const BoxConstraints(
      minHeight: 56,
    ),
  );

  // Dark Theme Input Field Configuration
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    
    // Border configurations
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.outline,
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.outline,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.primary,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.error,
        width: 1,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.error,
        width: 2,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.outline.withValues(alpha: 0.5),
        width: 1,
      ),
    ),
    
    // Label and hint styles
    labelStyle: AppTextStyles.formLabel.copyWith(
      color: AppColors.darkColorScheme.onSurfaceVariant,
    ),
    floatingLabelStyle: AppTextStyles.formLabel.copyWith(
      color: AppColors.darkColorScheme.primary,
    ),
    hintStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.darkColorScheme.onSurfaceVariant.withValues(alpha: 0.6),
    ),
    helperStyle: AppTextStyles.bodySmall.copyWith(
      color: AppColors.darkColorScheme.onSurfaceVariant.withValues(alpha: 0.8),
    ),
    errorStyle: AppTextStyles.formError.copyWith(
      color: AppColors.darkColorScheme.error,
    ),
    
    // Icon configuration
    prefixIconColor: AppColors.darkColorScheme.onSurfaceVariant,
    suffixIconColor: AppColors.darkColorScheme.onSurfaceVariant,
    
    // Constraints
    constraints: const BoxConstraints(
      minHeight: 56,
    ),
  );

  // Custom Input Decorations
  static InputDecoration primaryInputDecoration({
    required String labelText,
    String? hintText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool isDark = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark 
        ? AppColors.darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
        : AppColors.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.outline 
            : AppColors.gray300,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.outline 
            : AppColors.gray300,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.primary 
            : AppColors.primaryTeal,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  static InputDecoration searchInputDecoration({
    String? hintText = 'Search...',
    bool isDark = false,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: const Icon(Icons.search),
      filled: true,
      fillColor: isDark 
        ? AppColors.darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
        : AppColors.gray100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.primary 
            : AppColors.primaryTeal,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  static InputDecoration multilineInputDecoration({
    required String labelText,
    String? hintText,
    bool isDark = false,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      filled: true,
      fillColor: isDark 
        ? AppColors.darkColorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
        : AppColors.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.outline 
            : AppColors.gray300,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.outline 
            : AppColors.gray300,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: isDark 
            ? AppColors.darkColorScheme.primary 
            : AppColors.primaryTeal,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.all(16),
      alignLabelWithHint: true,
    );
  }
}