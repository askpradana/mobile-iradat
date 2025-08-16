import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors - Mental Health Focused
  static const Color primaryTeal = Color(0xFF006A6B);
  static const Color primaryTealLight = Color(0xFF4A9B9C);
  static const Color primaryTealDark = Color(0xFF003D3E);
  
  static const Color secondaryGreen = Color(0xFF4A6741);
  static const Color secondaryGreenLight = Color(0xFF7A9871);
  static const Color secondaryGreenDark = Color(0xFF2E3F28);
  
  static const Color tertiaryWarm = Color(0xFF6B7B8C);
  static const Color tertiaryWarmLight = Color(0xFF9BACBC);
  static const Color tertiaryWarmDark = Color(0xFF4A5666);

  // Semantic Colors
  static const Color success = Color(0xFF388E3C);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF1B5E20);
  
  static const Color warning = Color(0xFFf57C00);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFE65100);
  
  static const Color error = Color(0xFFD32F2F);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFB71C1C);
  
  static const Color info = Color(0xFF1976D2);
  static const Color infoLight = Color(0xFF42A5F5);
  static const Color infoDark = Color(0xFF0D47A1);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  
  // Light Theme Grays
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // Material 3 Light Color Scheme
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryTeal,
    onPrimary: white,
    primaryContainer: Color(0xFFB3E5E7),
    onPrimaryContainer: Color(0xFF002021),
    secondary: secondaryGreen,
    onSecondary: white,
    secondaryContainer: Color(0xFFD4E7CB),
    onSecondaryContainer: Color(0xFF131F0F),
    tertiary: tertiaryWarm,
    onTertiary: white,
    tertiaryContainer: Color(0xFFDAE6F2),
    onTertiaryContainer: Color(0xFF1A1F26),
    error: error,
    onError: white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: gray50,
    onSurface: gray900,
    surfaceContainerHighest: gray200,
    onSurfaceVariant: gray700,
    outline: gray400,
    outlineVariant: gray300,
    shadow: black,
    scrim: black,
    inverseSurface: gray800,
    onInverseSurface: gray100,
    inversePrimary: Color(0xFF66D4D8),
  );

  // Material 3 Dark Color Scheme
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF66D4D8),
    onPrimary: Color(0xFF003738),
    primaryContainer: Color(0xFF004F51),
    onPrimaryContainer: Color(0xFFB3E5E7),
    secondary: Color(0xFFB8CBAF),
    onSecondary: Color(0xFF243423),
    secondaryContainer: Color(0xFF3A4A37),
    onSecondaryContainer: Color(0xFFD4E7CB),
    tertiary: Color(0xFFBBCAD6),
    onTertiary: Color(0xFF26323C),
    tertiaryContainer: Color(0xFF3C4853),
    onTertiaryContainer: Color(0xFFDAE6F2),
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF0F1419),
    onSurface: Color(0xFFE1E2E8),
    surfaceContainerHighest: Color(0xFF3F484A),
    onSurfaceVariant: Color(0xFFBFC8CA),
    outline: Color(0xFF899294),
    outlineVariant: Color(0xFF3F484A),
    shadow: black,
    scrim: black,
    inverseSurface: Color(0xFFE1E2E8),
    onInverseSurface: Color(0xFF2F3036),
    inversePrimary: primaryTeal,
  );

  // Assessment Card Colors
  static const Color assessmentBlue = Color(0xFF1976D2);
  static const Color assessmentGreen = Color(0xFF388E3C);
  static const Color assessmentOrange = Color(0xFFF57C00);
  static const Color assessmentPurple = Color(0xFF7B1FA2);

  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryTeal, primaryTealLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [secondaryGreen, secondaryGreenLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Helper Methods
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }

  static Color getAssessmentColor(int index) {
    const colors = [
      assessmentBlue,
      assessmentGreen,
      assessmentOrange,
      assessmentPurple,
    ];
    return colors[index % colors.length];
  }
}