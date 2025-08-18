import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/features/anonymous_quiz/presentation/controllers/anonymous_quiz_controller.dart';
import 'features/auth/auth_binding.dart';
import 'features/auth/presentation/pages/onboarding_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/register_page.dart';
import 'features/profile/profile_binding.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/home/home_binding.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/anonymous_quiz/anonymous_binding.dart';
import 'features/anonymous_quiz/presentation/pages/anonymous_code_page.dart';
import 'features/anonymous_quiz/presentation/pages/anonymous_form_page.dart';
import 'features/anonymous_quiz/presentation/pages/anonymous_quiz_page.dart';
import 'features/anonymous_quiz/presentation/pages/congrats_page.dart';

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
  static const anonymousCode = '/anonymous-code';
  static const anonymousForm = '/anonymous-form';
  static const anonymousQuiz = '/anonymous-quiz';
  static const congrats = '/congrats';
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

    // Anonymous quiz routes
    GetPage(
      name: AppRoutes.anonymousCode,
      page: () => const AnonymousCodePage(),
      binding: AnonymousBinding(),
    ),
    GetPage(
      name: AppRoutes.anonymousForm,
      page: () => const AnonymousFormPage(),
      binding: AnonymousBinding(),
      middlewares: [_AnonymousFlowMiddleware()],
    ),
    GetPage(
      name: AppRoutes.anonymousQuiz,
      page: () => const AnonymousQuizPage(),
      binding: AnonymousBinding(),
      middlewares: [_AnonymousFlowMiddleware()],
    ),
    GetPage(
      name: AppRoutes.congrats,
      page: () => const CongratsPage(),
      binding: AnonymousBinding(),
      middlewares: [_AnonymousFlowMiddleware()],
    ),

    // Other routes will be added as we migrate each feature
  ];
}

class _AnonymousFlowMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Basic route guard: ensure controller exists
    try {
      Get.find<AnonymousQuizController>();
      return null; // Allow navigation
    } catch (e) {
      // If controller not found, redirect to code entry
      return const RouteSettings(name: AppRoutes.anonymousCode);
    }
  }
}
