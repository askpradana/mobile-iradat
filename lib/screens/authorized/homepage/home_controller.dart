import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/quizdescriptionscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:quiz_iradat/screens/auth/login/login_view.dart';
import 'package:quiz_iradat/settings/supabase.dart';

class HomeController extends GetxController {
  final quizzes = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;
  int get quizCount => quizzes.length;
  bool get isQuizEmpty => quizzes.isEmpty;
  bool get isLastQuiz => currentIndex.value == quizCount - 1;
  final List<String> bottomNavbarTitles = ['Quizzes', 'Profile'];

  @override
  void onInit() {
    super.onInit();
    loadQuizzes();
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

  // Updated logout method using GetX dialogs
  Future<void> handleLogout() async {
    // Show confirmation dialog first
    final bool? shouldLogout = await _showLogoutConfirmation();

    if (shouldLogout != true) return;

    // Show loading dialog with animation
    _showLoadingDialog();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    try {
      if (token != null) {
        await http.post(
          Uri.parse('$supabaseUrl/auth/v1/logout'),
          headers: {
            'Content-Type': 'application/json',
            'apikey': supabaseAPIKey,
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

      await prefs.remove('auth_token');

      // Add fade transition to login
      Get.offAll(
        () => const LoginView(),
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  // Confirmation dialog using GetX
  Future<bool?> _showLogoutConfirmation() {
    return Get.dialog<bool>(
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: AlertDialog(
              backgroundColor: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                children: [
                  Icon(Icons.logout_rounded, color: Colors.red[600], size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Logout Confirmation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              content: const Text(
                'Are you sure you want to logout? You will need to sign in again to access your account.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    foregroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }

  // Loading dialog using GetX
  void _showLoadingDialog() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * 2 * 3.14159,
                      child: Icon(
                        Icons.logout_rounded,
                        size: 48,
                        color: Colors.red[600],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  'Logging out...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please wait while we securely log you out',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const LinearProgressIndicator(
                  color: Colors.green,
                  backgroundColor: Colors.greenAccent,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
