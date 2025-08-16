import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import '../../data/auth_repository.dart';
import '../../models.dart';

class OnboardingController extends GetxController {
  final AuthRepository repo;

  OnboardingController(this.repo);

  final pageController = PageController();
  final currentIndex = 0.obs;

  final onboardingItems = [
    const OnboardingItem(
      title: 'Welcome to Quiz Iradat',
      description: 'Take psychological assessments to understand your mental health better.',
      imagePath: 'assets/images/onboarding1.png',
    ),
    const OnboardingItem(
      title: 'Professional Assessments',
      description: 'Access DASS-21, SRQ-20, and SMFA-10 validated assessment tools.',
      imagePath: 'assets/images/onboarding2.png',
    ),
    const OnboardingItem(
      title: 'Track Your Progress',
      description: 'Monitor your mental health journey with detailed reports and insights.',
      imagePath: 'assets/images/onboarding3.png',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeOnboarding();
    _checkAuthStatus();
  }

  void _initializeOnboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      FlutterNativeSplash.remove();
    });
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await repo.isLoggedIn();
    if (isLoggedIn) {
      final currentUser = await repo.getCurrentUser();
      if (currentUser != null) {
        Get.offAllNamed('/home');
      }
    }
  }

  void nextPage() {
    if (currentIndex.value < onboardingItems.length - 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed('/login');
    }
  }

  void skipToLogin() {
    Get.offAllNamed('/login');
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}