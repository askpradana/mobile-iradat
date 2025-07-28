import 'package:get/get.dart';
import 'package:quiz_iradat/screens/auth/onboarding/landing_view.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/aboutapplication_settings.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/applicationsettings_view.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/contactus_settings.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/faq_settings.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/privacypoplicy_settings.dart';
import 'package:quiz_iradat/screens/authorized/application_settings/profilesettings_view.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_view.dart';

// Route names
abstract class AppRoutes {
  static const landing = '/landing';
  static const home = '/home';
  static const settings = '/settings';
  static const editProfile = '/editProfile';
  static const aboutApplication = '/aboutApplication';
  static const faq = '/faq';
  static const contactUs = '/contactUs';
  static const privacyPolicy = '/privacyPolicy';
  static const faqDetails = '/faqDetails';
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

    // Settings
    GetPage(name: AppRoutes.editProfile, page: () => ProfilesettingsView()),
    GetPage(name: AppRoutes.settings, page: () => const ApplicationSettings()),
    GetPage(
      name: AppRoutes.aboutApplication,
      page: () => const AboutApplicationSettings(),
    ),
    GetPage(name: AppRoutes.faq, page: () => const FaqSettings()),
    GetPage(name: AppRoutes.contactUs, page: () => const ContactusSettings()),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicySettings(),
    ),
  ];
}
