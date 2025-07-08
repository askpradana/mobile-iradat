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

  Future<void> handleLogout(BuildContext context) async {
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
    } catch (e) {
      debugPrint('Logout API call failed: $e');
    } finally {
      await prefs.remove('auth_token');
      if (context.mounted) {
        Get.offAll(() => const LoginView());
      }
    }
  }
}
