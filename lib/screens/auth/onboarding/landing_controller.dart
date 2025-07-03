import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_view.dart';
import 'package:quiz_iradat/screens/auth/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    pageController = PageController(viewportFraction: 0.75);
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null && token.isNotEmpty) {
      // Navigate to home screen using GetX navigation
      Get.offAll(() => const Homescreen());
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

class OnboardingItem {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
  });
}
