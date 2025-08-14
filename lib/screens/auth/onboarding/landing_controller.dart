import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/auth/login/login_view.dart';
import 'package:quiz_iradat/screens/auth/onboarding/landing_model.dart';
import 'package:quiz_iradat/settings/route_management.dart';
import 'package:quiz_iradat/core/services/auth_storage_service.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class LandingController extends GetxController {
  late PageController pageController;
  late List<OnboardingItem> items;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
    _checkAuthToken();
    pageController = PageController(viewportFraction: 0.9);
    items = [
      OnboardingItem(
        title: 'Feature Highlights',
        subtitle: 'Discover the best features',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        icon: Icons.star,
        color: Colors.blue,
      ),
      OnboardingItem(
        title: 'How It Works',
        subtitle: 'Learn how it works',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        icon: Icons.work,
        color: Colors.green,
      ),
      OnboardingItem(
        title: 'Why Choose Us',
        subtitle: 'Why choose our service',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
        icon: Icons.favorite,
        color: Colors.red,
      ),
    ];
  }

  Future<void> _checkAuthToken() async {
    final isAuthenticated = await AuthStorageService.isAuthenticated();
    if (isAuthenticated) {
      // Navigate to home screen using GetX navigation
      Get.offAllNamed(AppRoutes.home);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.to(() => const LoginView());
    }
  }

  void skipOnboarding() {
    Get.to(() => const LoginView());
  }
}
