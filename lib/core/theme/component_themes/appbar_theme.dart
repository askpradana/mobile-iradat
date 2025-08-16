import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppBarThemeConfig {
  // Light Theme AppBar Configuration
  static AppBarTheme lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    shadowColor: AppColors.shadowLight,
    surfaceTintColor: AppColors.white,
    backgroundColor: AppColors.white,
    foregroundColor: AppColors.gray900,
    centerTitle: true,
    titleSpacing: 16,
    
    // Title text style
    titleTextStyle: AppTextStyles.appBarTitle.copyWith(
      color: AppColors.gray900,
    ),
    
    // Icon theme
    iconTheme: IconThemeData(
      color: AppColors.gray700,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.gray700,
      size: 24,
    ),
    
    // System overlay style (status bar)
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
    
    // Toolbar configuration
    toolbarHeight: 56,
    toolbarTextStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.gray700,
    ),
  );

  // Dark Theme AppBar Configuration
  static AppBarTheme darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    shadowColor: AppColors.shadowMedium,
    surfaceTintColor: AppColors.darkColorScheme.surface,
    backgroundColor: AppColors.darkColorScheme.surface,
    foregroundColor: AppColors.darkColorScheme.onSurface,
    centerTitle: true,
    titleSpacing: 16,
    
    // Title text style
    titleTextStyle: AppTextStyles.appBarTitle.copyWith(
      color: AppColors.darkColorScheme.onSurface,
    ),
    
    // Icon theme
    iconTheme: IconThemeData(
      color: AppColors.darkColorScheme.onSurface,
      size: 24,
    ),
    actionsIconTheme: IconThemeData(
      color: AppColors.darkColorScheme.onSurface,
      size: 24,
    ),
    
    // System overlay style (status bar)
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.darkColorScheme.surface,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
    
    // Toolbar configuration
    toolbarHeight: 56,
    toolbarTextStyle: AppTextStyles.bodyMedium.copyWith(
      color: AppColors.darkColorScheme.onSurface,
    ),
  );

  // Custom AppBar Styles
  static AppBar primaryAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
    bool isDark = false,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.appBarTitle.copyWith(
          color: isDark 
            ? AppColors.darkColorScheme.onSurface 
            : AppColors.gray900,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      elevation: 0,
      backgroundColor: isDark 
        ? AppColors.darkColorScheme.surface 
        : AppColors.white,
      foregroundColor: isDark 
        ? AppColors.darkColorScheme.onSurface 
        : AppColors.gray900,
      iconTheme: IconThemeData(
        color: isDark 
          ? AppColors.darkColorScheme.onSurface 
          : AppColors.gray700,
        size: 24,
      ),
      systemOverlayStyle: isDark 
        ? SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          )
        : SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
    );
  }

  static AppBar gradientAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.appBarTitle.copyWith(
          color: AppColors.white,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.white,
      iconTheme: const IconThemeData(
        color: AppColors.white,
        size: 24,
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  static AppBar transparentAppBar({
    required String title,
    List<Widget>? actions,
    Widget? leading,
    bool centerTitle = true,
    Color? titleColor,
    Color? iconColor,
  }) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.appBarTitle.copyWith(
          color: titleColor ?? AppColors.white,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: leading,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: titleColor ?? AppColors.white,
      iconTheme: IconThemeData(
        color: iconColor ?? AppColors.white,
        size: 24,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: (titleColor ?? AppColors.white) == AppColors.white
          ? Brightness.dark
          : Brightness.light,
        statusBarIconBrightness: (titleColor ?? AppColors.white) == AppColors.white
          ? Brightness.light
          : Brightness.dark,
      ),
    );
  }

  static AppBar minimalAppBar({
    String? title,
    List<Widget>? actions,
    Widget? leading,
    bool showBackButton = true,
    bool isDark = false,
  }) {
    return AppBar(
      title: title != null 
        ? Text(
            title,
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark 
                ? AppColors.darkColorScheme.onSurface 
                : AppColors.gray900,
            ),
          ) 
        : null,
      centerTitle: false,
      actions: actions,
      leading: showBackButton ? leading : const SizedBox.shrink(),
      automaticallyImplyLeading: showBackButton,
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: isDark 
        ? AppColors.darkColorScheme.onSurface 
        : AppColors.gray900,
      iconTheme: IconThemeData(
        color: isDark 
          ? AppColors.darkColorScheme.onSurface 
          : AppColors.gray700,
        size: 20,
      ),
      systemOverlayStyle: isDark 
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.dark,
          ),
    );
  }
}