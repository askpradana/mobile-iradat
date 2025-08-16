import 'package:get/get.dart';
import 'features/auth/auth_binding.dart';
import 'features/auth/presentation/pages/onboarding_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/profile/profile_binding.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/home/home_binding.dart';
import 'features/home/presentation/pages/home_page.dart';

abstract class AppRoutes {
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/profile';
  static const settings = '/settings';
  static const about = '/about';
  static const faq = '/faq';
  static const contact = '/contact';
  static const privacy = '/privacy';
  static const quizList = '/quiz-list';
  static const quizDetail = '/quiz-detail';
  static const quizResult = '/quiz-result';
}

class AppPages {
  static const initial = AppRoutes.onboarding;

  static final routes = <GetPage>[
    // Auth routes
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
      binding: AuthBinding(),
    ),
    
    // Home routes
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    
    // Profile routes
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    
    // Other routes will be added as we migrate each feature
  ];
}