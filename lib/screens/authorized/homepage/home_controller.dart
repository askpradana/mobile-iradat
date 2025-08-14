import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/core/services/auth_storage_service.dart';
import 'package:quiz_iradat/data/models/user_model.dart';
import 'package:quiz_iradat/data/models/service_model.dart';
import 'package:quiz_iradat/screens/quizdescriptionscreen.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:quiz_iradat/screens/auth/login/login_view.dart';
import 'package:quiz_iradat/settings/supabase.dart';
import 'package:quiz_iradat/widgets/modaldialog.dart';

class HomeController extends GetxController {
  final quizzes = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;
  int get quizCount => quizzes.length;
  bool get isQuizEmpty => quizzes.isEmpty;
  bool get isLastQuiz => currentIndex.value == quizCount - 1;
  final List<String> bottomNavbarTitles = ['Quizzes', 'Profile'];
  var isDarkMode = false.obs;
  var themeMode = ThemeMode.system.obs;
  
  // User and services data from login
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxList<ServiceModel> availableServices = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQuizzes();
    loadUserData();
    loadServicesData();
  }

  void toggleTheme(int index) {
    switch (index) {
      case 0:
        themeMode.value = ThemeMode.light;
        break;
      case 1:
        themeMode.value = ThemeMode.dark;
        break;
      case 2:
        themeMode.value = ThemeMode.system;
        break;
    }
    Get.changeThemeMode(themeMode.value);
  }

  Map<String, dynamic> getQuizByIndex(int index) {
    return quizzes[index];
  }

  bool isQuizAvailableByIndex(int index) {
    return quizzes[index]['isAvailable'];
  }

  Future<void> loadQuizzes() async {
    try {
      final jsonString = await rootBundle.loadString('lib/data/quizzes.json');
      final jsonData = json.decode(jsonString);
      quizzes.assignAll(List<Map<String, dynamic>>.from(jsonData['quizzes']));
    } catch (e) {
      debugPrint('Error loading quizzes: $e');
    }
  }
  
  Future<void> loadUserData() async {
    try {
      final user = await AuthStorageService.getUserData();
      if (user != null) {
        currentUser.value = user;
        debugPrint('Loaded user: ${user.name} (${user.email})');
      }
    } catch (e) {
      debugPrint('Error loading user data: $e');
    }
  }
  
  Future<void> loadServicesData() async {
    try {
      final services = await AuthStorageService.getServicesData();
      if (services != null) {
        availableServices.assignAll(services);
        debugPrint('Loaded ${services.length} services');
      }
    } catch (e) {
      debugPrint('Error loading services data: $e');
    }
  }

  Function()? navigateToQuizScreen(int index) {
    if (isQuizAvailableByIndex(index)) {
      return () {
        Get.to(
          () => QuizScreen(
            quizTitle: getQuizByIndex(currentIndex.value)['title'],
            quizId: getQuizByIndex(currentIndex.value)['id'],
            totalQuestions: getQuizByIndex(currentIndex.value)['questions'],
            timeLimit: getQuizByIndex(currentIndex.value)['timeLimit'],
            quizDescription: getQuizByIndex(currentIndex.value)['description'],
            quizType: getQuizByIndex(currentIndex.value)['quizType'],
          ),
        );
      };
    }
    return null;
  }

  Future<void> handleLogout() async {
    // Show confirmation dialog first
    final bool? shouldLogout = await ModalDialog.showLogoutConfirmation();

    if (shouldLogout != true) return;

    // Show loading dialog with animation
    ModalDialog.showLoadingDialog();

    try {
      final token = await AuthStorageService.getAuthToken();
      
      if (token != null) {
        // Make logout API call with new backend
        await http.post(
          Uri.parse('$backendBaseUrl/auth/logout'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );
      }

      // Add slight delay for better UX
      await Future.delayed(const Duration(milliseconds: 800));
    } catch (e) {
      debugPrint('Logout API call failed: $e');
    } finally {
      // Close loading dialog
      Get.back();

      // Clear all authentication data
      await AuthStorageService.clearAuthData();
      
      // Clear local state
      currentUser.value = null;
      availableServices.clear();

      // Add fade transition to login
      Get.offAll(
        () => const LoginView(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    }
  }
}
