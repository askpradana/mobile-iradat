import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../app_text_styles.dart';

class AppNavigationTheme {
  // Light Theme Bottom Navigation Configuration
  static BottomNavigationBarThemeData lightBottomNavigationBarTheme = BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.white,
    selectedItemColor: AppColors.primaryTeal,
    unselectedItemColor: AppColors.gray600,
    selectedIconTheme: const IconThemeData(
      size: 24,
      color: AppColors.primaryTeal,
    ),
    unselectedIconTheme: IconThemeData(
      size: 24,
      color: AppColors.gray600,
    ),
    selectedLabelStyle: AppTextStyles.navigationLabel.copyWith(
      color: AppColors.primaryTeal,
      fontWeight: AppTextStyles.semiBold,
    ),
    unselectedLabelStyle: AppTextStyles.navigationLabel.copyWith(
      color: AppColors.gray600,
      fontWeight: AppTextStyles.medium,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 8,
  );

  // Dark Theme Bottom Navigation Configuration
  static BottomNavigationBarThemeData darkBottomNavigationBarTheme = BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.darkColorScheme.surface,
    selectedItemColor: AppColors.darkColorScheme.primary,
    unselectedItemColor: AppColors.darkColorScheme.onSurfaceVariant,
    selectedIconTheme: IconThemeData(
      size: 24,
      color: AppColors.darkColorScheme.primary,
    ),
    unselectedIconTheme: IconThemeData(
      size: 24,
      color: AppColors.darkColorScheme.onSurfaceVariant,
    ),
    selectedLabelStyle: AppTextStyles.navigationLabel.copyWith(
      color: AppColors.darkColorScheme.primary,
      fontWeight: AppTextStyles.semiBold,
    ),
    unselectedLabelStyle: AppTextStyles.navigationLabel.copyWith(
      color: AppColors.darkColorScheme.onSurfaceVariant,
      fontWeight: AppTextStyles.medium,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 8,
  );

  // Navigation Drawer Theme
  static DrawerThemeData lightDrawerTheme = DrawerThemeData(
    backgroundColor: AppColors.white,
    scrimColor: AppColors.black.withValues(alpha: 0.5),
    elevation: 16,
    shadowColor: AppColors.shadowMedium,
    surfaceTintColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
  );

  static DrawerThemeData darkDrawerTheme = DrawerThemeData(
    backgroundColor: AppColors.darkColorScheme.surface,
    scrimColor: AppColors.black.withValues(alpha: 0.7),
    elevation: 16,
    shadowColor: AppColors.shadowDark,
    surfaceTintColor: AppColors.darkColorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
  );

  // Navigation Rail Theme
  static NavigationRailThemeData lightNavigationRailTheme = NavigationRailThemeData(
    backgroundColor: AppColors.white,
    elevation: 1,
    selectedIconTheme: const IconThemeData(
      color: AppColors.primaryTeal,
      size: 24,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.gray600,
      size: 24,
    ),
    selectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
      color: AppColors.primaryTeal,
      fontWeight: AppTextStyles.semiBold,
    ),
    unselectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
      color: AppColors.gray600,
    ),
    groupAlignment: 0.0,
    labelType: NavigationRailLabelType.selected,
    useIndicator: true,
    indicatorColor: AppColors.primaryTeal.withValues(alpha: 0.1),
  );

  static NavigationRailThemeData darkNavigationRailTheme = NavigationRailThemeData(
    backgroundColor: AppColors.darkColorScheme.surface,
    elevation: 1,
    selectedIconTheme: IconThemeData(
      color: AppColors.darkColorScheme.primary,
      size: 24,
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.darkColorScheme.onSurfaceVariant,
      size: 24,
    ),
    selectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
      color: AppColors.darkColorScheme.primary,
      fontWeight: AppTextStyles.semiBold,
    ),
    unselectedLabelTextStyle: AppTextStyles.labelMedium.copyWith(
      color: AppColors.darkColorScheme.onSurfaceVariant,
    ),
    groupAlignment: 0.0,
    labelType: NavigationRailLabelType.selected,
    useIndicator: true,
    indicatorColor: AppColors.darkColorScheme.primary.withValues(alpha: 0.1),
  );

  // Tab Bar Theme
  static TabBarThemeData lightTabBarTheme = TabBarThemeData(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: AppColors.primaryTeal,
        width: 3,
      ),
      insets: const EdgeInsets.symmetric(horizontal: 16),
    ),
    labelColor: AppColors.primaryTeal,
    unselectedLabelColor: AppColors.gray600,
    labelStyle: AppTextStyles.titleSmall.copyWith(
      fontWeight: AppTextStyles.semiBold,
    ),
    unselectedLabelStyle: AppTextStyles.titleSmall.copyWith(
      fontWeight: AppTextStyles.medium,
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.hovered)) {
        return AppColors.primaryTeal.withValues(alpha: 0.04);
      }
      if (states.contains(WidgetState.pressed)) {
        return AppColors.primaryTeal.withValues(alpha: 0.12);
      }
      return null;
    }),
    splashFactory: InkRipple.splashFactory,
  );

  static TabBarThemeData darkTabBarTheme = TabBarThemeData(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: AppColors.darkColorScheme.primary,
        width: 3,
      ),
      insets: const EdgeInsets.symmetric(horizontal: 16),
    ),
    labelColor: AppColors.darkColorScheme.primary,
    unselectedLabelColor: AppColors.darkColorScheme.onSurfaceVariant,
    labelStyle: AppTextStyles.titleSmall.copyWith(
      fontWeight: AppTextStyles.semiBold,
    ),
    unselectedLabelStyle: AppTextStyles.titleSmall.copyWith(
      fontWeight: AppTextStyles.medium,
    ),
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.hovered)) {
        return AppColors.darkColorScheme.primary.withValues(alpha: 0.04);
      }
      if (states.contains(WidgetState.pressed)) {
        return AppColors.darkColorScheme.primary.withValues(alpha: 0.12);
      }
      return null;
    }),
    splashFactory: InkRipple.splashFactory,
  );

  // Custom Navigation Styles
  static BottomNavigationBarItem buildNavigationItem({
    required IconData icon,
    required String label,
    IconData? activeIcon,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      activeIcon: activeIcon != null ? Icon(activeIcon) : null,
      label: label,
      tooltip: label,
    );
  }

  static Widget buildDrawerHeader({
    required String title,
    String? subtitle,
    Widget? accountPicture,
    bool isDark = false,
  }) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: isDark 
          ? LinearGradient(
              colors: [
                AppColors.darkColorScheme.primary,
                AppColors.darkColorScheme.primaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : AppColors.primaryGradient,
      ),
      child: DrawerHeader(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (accountPicture != null) ...[
              accountPicture,
              const SizedBox(height: 16),
            ],
            Text(
              title,
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.white,
                fontWeight: AppTextStyles.bold,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static Widget buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isSelected = false,
    bool isDark = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected 
          ? (isDark 
              ? AppColors.darkColorScheme.primaryContainer 
              : AppColors.primaryTeal.withValues(alpha: 0.1))
          : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected 
            ? (isDark 
                ? AppColors.darkColorScheme.onPrimaryContainer 
                : AppColors.primaryTeal)
            : (isDark 
                ? AppColors.darkColorScheme.onSurfaceVariant 
                : AppColors.gray600),
        ),
        title: Text(
          title,
          style: AppTextStyles.bodyLarge.copyWith(
            color: isSelected 
              ? (isDark 
                  ? AppColors.darkColorScheme.onPrimaryContainer 
                  : AppColors.primaryTeal)
              : (isDark 
                  ? AppColors.darkColorScheme.onSurface 
                  : AppColors.gray800),
            fontWeight: isSelected 
              ? AppTextStyles.semiBold 
              : AppTextStyles.medium,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}