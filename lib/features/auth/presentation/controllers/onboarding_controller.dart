import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../../presentation/controllers/base_controller.dart';
import '../../../../domain/usecases/get_auth_status_usecase.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../settings/route_management.dart';
import '../../../auth/domain/entities/onboarding_item.dart';
import '../views/login_view.dart';

class OnboardingController extends BaseController {
  final GetAuthStatusUseCase getAuthStatusUseCase;
  
  OnboardingController({required this.getAuthStatusUseCase});
  
  late PageController pageController;
  late List<OnboardingItem> items;
  final currentPage = 0.obs;
  
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
    
    pageController = PageController(viewportFraction: 0.9);
    items = [
      const OnboardingItem(
        title: 'Comprehensive Mental Health Assessment',
        subtitle: 'Professional psychological evaluations',
        description: 'Take scientifically validated questionnaires designed by mental health professionals to assess your psychological well-being.',
        icon: Icons.psychology_outlined,
        color: Colors.blue,
      ),
      const OnboardingItem(
        title: 'Personalized Insights',
        subtitle: 'Get detailed analysis of your results',
        description: 'Receive comprehensive reports and recommendations based on your assessment results to better understand your mental health.',
        icon: Icons.insights_outlined,
        color: Colors.green,
      ),
      const OnboardingItem(
        title: 'Track Your Progress',
        subtitle: 'Monitor your mental health journey',
        description: 'Keep track of your progress over time with detailed analytics and personalized recommendations for improvement.',
        icon: Icons.trending_up_outlined,
        color: Colors.orange,
      ),
    ];
  }
  
  Future<void> _checkAuthStatus() async {
    LoggerService.info('Checking authentication status');
    
    final result = await getAuthStatusUseCase();
    result.fold(
      (failure) {
        LoggerService.warning('Failed to check auth status: ${failure.message}');
      },
      (isLoggedIn) {
        if (isLoggedIn) {
          LoggerService.info('User is already logged in, navigating to home');
          Get.offAllNamed(AppRoutes.home);
        }
      },
    );
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
      _navigateToLogin();
    }
  }
  
  void skipOnboarding() {
    _navigateToLogin();
  }
  
  void _navigateToLogin() {
    LoggerService.info('Navigating to login screen');
    Get.to(() => const LoginView());
  }
}