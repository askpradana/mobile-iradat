import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:quiz_iradat/screens/auth/login/login_view.dart';
import 'package:quiz_iradat/settings/supabase.dart';

class HomeController extends GetxController {
  final quizzes = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuizzes();
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
