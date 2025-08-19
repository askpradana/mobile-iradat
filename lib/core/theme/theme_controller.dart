import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // Theme mode observable
  final _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;

  // Initialization state
  final _isInitialized = false.obs;
  bool get isInitialized => _isInitialized.value;

  // Key for SharedPreferences
  static const String _themeModeKey = 'theme_mode';

  @override
  void onInit() {
    super.onInit();
    _loadThemeMode();
  }

  /// Load saved theme mode from SharedPreferences
  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeMode = prefs.getString(_themeModeKey);
      
      if (savedThemeMode != null) {
        _themeMode.value = _parseThemeMode(savedThemeMode);
        Get.changeThemeMode(_themeMode.value);
      }
    } catch (e) {
      debugPrint('Error loading theme mode: $e');
    } finally {
      // Mark as initialized regardless of success/failure
      _isInitialized.value = true;
    }
  }

  /// Save theme mode to SharedPreferences
  Future<void> _saveThemeMode(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themeModeKey, mode.name);
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  /// Parse string to ThemeMode
  ThemeMode _parseThemeMode(String themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Change theme to light mode
  Future<void> setLightTheme() async {
    _themeMode.value = ThemeMode.light;
    Get.changeThemeMode(ThemeMode.light);
    await _saveThemeMode(ThemeMode.light);
  }

  /// Change theme to dark mode
  Future<void> setDarkTheme() async {
    _themeMode.value = ThemeMode.dark;
    Get.changeThemeMode(ThemeMode.dark);
    await _saveThemeMode(ThemeMode.dark);
  }

  /// Change theme to system mode (follows device settings)
  Future<void> setSystemTheme() async {
    _themeMode.value = ThemeMode.system;
    Get.changeThemeMode(ThemeMode.system);
    await _saveThemeMode(ThemeMode.system);
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    if (_themeMode.value == ThemeMode.light) {
      await setDarkTheme();
    } else {
      await setLightTheme();
    }
  }

  /// Check if current theme is dark
  bool get isDarkMode {
    if (_themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode;
    }
    return _themeMode.value == ThemeMode.dark;
  }

  /// Check if current theme is light
  bool get isLightMode {
    if (_themeMode.value == ThemeMode.system) {
      return !Get.isPlatformDarkMode;
    }
    return _themeMode.value == ThemeMode.light;
  }

  /// Check if current theme is system
  bool get isSystemMode => _themeMode.value == ThemeMode.system;

  /// Get theme mode display name
  String get themeModeDisplayName {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  /// Get theme mode icon
  IconData get themeModeIcon {
    switch (_themeMode.value) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.brightness_auto;
    }
  }

  /// Get current theme brightness
  Brightness get currentBrightness {
    if (_themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode ? Brightness.dark : Brightness.light;
    }
    return _themeMode.value == ThemeMode.dark ? Brightness.dark : Brightness.light;
  }

  /// Listen to system theme changes when in system mode
  void handleSystemThemeChange() {
    if (_themeMode.value == ThemeMode.system) {
      // This will trigger a rebuild when system theme changes
      update();
    }
  }
}