import 'package:get/get.dart';
import 'package:quiz_iradat/screens/auth/onboarding/landing_view.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/settings_view.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_view.dart';

// Route names
abstract class AppRoutes {
  static const landing = '/landing';
  static const home = '/home';
  static const settings = '/settings';
}

// Page definitions
class AppPages {
  static const initial = AppRoutes.landing;

  static final routes = [
    GetPage(name: AppRoutes.landing, page: () => const LandingScreen()),
    GetPage(
      name: AppRoutes.home,
      page: () => const Homescreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(name: AppRoutes.settings, page: () => const SettingsView()),
  ];
}
