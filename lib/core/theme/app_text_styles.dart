import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font Family
  static const String fontFamily = 'Roboto';

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // Light Theme Text Styles
  static TextTheme lightTextTheme = TextTheme(
    // Display Styles
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 57,
      height: 1.12,
      letterSpacing: -0.25,
      color: AppColors.gray900,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 45,
      height: 1.16,
      color: AppColors.gray900,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 36,
      height: 1.22,
      color: AppColors.gray900,
    ),

    // Headline Styles
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 32,
      height: 1.25,
      color: AppColors.gray900,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 28,
      height: 1.29,
      color: AppColors.gray900,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 24,
      height: 1.33,
      color: AppColors.gray900,
    ),

    // Title Styles
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 22,
      height: 1.27,
      color: AppColors.gray900,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.15,
      color: AppColors.gray900,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.10,
      color: AppColors.gray900,
    ),

    // Body Styles
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.15,
      color: AppColors.gray800,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      color: AppColors.gray700,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.40,
      color: AppColors.gray600,
    ),

    // Label Styles
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.10,
      color: AppColors.gray800,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.50,
      color: AppColors.gray700,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.50,
      color: AppColors.gray600,
    ),
  );

  // Dark Theme Text Styles
  static TextTheme darkTextTheme = TextTheme(
    // Display Styles
    displayLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 57,
      height: 1.12,
      letterSpacing: -0.25,
      color: AppColors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 45,
      height: 1.16,
      color: AppColors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 36,
      height: 1.22,
      color: AppColors.white,
    ),

    // Headline Styles
    headlineLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 32,
      height: 1.25,
      color: AppColors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 28,
      height: 1.29,
      color: AppColors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 24,
      height: 1.33,
      color: AppColors.white,
    ),

    // Title Styles
    titleLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 22,
      height: 1.27,
      color: AppColors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.15,
      color: AppColors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.10,
      color: AppColors.white,
    ),

    // Body Styles
    bodyLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 16,
      height: 1.50,
      letterSpacing: 0.15,
      color: AppColors.gray200,
    ),
    bodyMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      color: AppColors.gray300,
    ),
    bodySmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: regular,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.40,
      color: AppColors.gray400,
    ),

    // Label Styles
    labelLarge: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.10,
      color: AppColors.gray200,
    ),
    labelMedium: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.50,
      color: AppColors.gray300,
    ),
    labelSmall: TextStyle(
      fontFamily: fontFamily,
      fontWeight: medium,
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.50,
      color: AppColors.gray400,
    ),
  );

  // Custom Text Styles for specific use cases
  static const TextStyle buttonText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: 16,
    letterSpacing: 0.10,
  );

  static const TextStyle cardTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: 18,
    height: 1.22,
  );

  static const TextStyle cardSubtitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: 14,
    height: 1.43,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: semiBold,
    fontSize: 20,
    letterSpacing: 0.15,
  );

  static const TextStyle navigationLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: 12,
    letterSpacing: 0.50,
  );

  static const TextStyle formLabel = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: 14,
    letterSpacing: 0.10,
  );

  static const TextStyle formError = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: 12,
    letterSpacing: 0.40,
  );

  static const TextStyle snackbarText = TextStyle(
    fontFamily: fontFamily,
    fontWeight: medium,
    fontSize: 14,
    letterSpacing: 0.25,
  );

  // Assessment specific styles
  static const TextStyle assessmentTitle = TextStyle(
    fontFamily: fontFamily,
    fontWeight: bold,
    fontSize: 20,
    height: 1.25,
  );

  static const TextStyle assessmentDescription = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: 14,
    height: 1.50,
  );

  static const TextStyle profileName = TextStyle(
    fontFamily: fontFamily,
    fontWeight: bold,
    fontSize: 24,
    height: 1.33,
  );

  static const TextStyle profileSubtext = TextStyle(
    fontFamily: fontFamily,
    fontWeight: regular,
    fontSize: 16,
    height: 1.50,
  );

  // Static getters for individual text styles (for direct access)
  static TextStyle get bodySmall => lightTextTheme.bodySmall!;
  static TextStyle get bodyMedium => lightTextTheme.bodyMedium!;
  static TextStyle get bodyLarge => lightTextTheme.bodyLarge!;
  static TextStyle get titleSmall => lightTextTheme.titleSmall!;
  static TextStyle get titleMedium => lightTextTheme.titleMedium!;
  static TextStyle get titleLarge => lightTextTheme.titleLarge!;
  static TextStyle get headlineSmall => lightTextTheme.headlineSmall!;
  static TextStyle get headlineMedium => lightTextTheme.headlineMedium!;
  static TextStyle get headlineLarge => lightTextTheme.headlineLarge!;
  static TextStyle get displaySmall => lightTextTheme.displaySmall!;
  static TextStyle get displayMedium => lightTextTheme.displayMedium!;
  static TextStyle get displayLarge => lightTextTheme.displayLarge!;
  static TextStyle get labelSmall => lightTextTheme.labelSmall!;
  static TextStyle get labelMedium => lightTextTheme.labelMedium!;
  static TextStyle get labelLarge => lightTextTheme.labelLarge!;
}