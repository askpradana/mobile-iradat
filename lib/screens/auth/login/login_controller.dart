import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_iradat/settings/route_management.dart';
import 'package:quiz_iradat/settings/supabase.dart';
import 'package:quiz_iradat/widgets/snackbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> handleLogin(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (isLoading.value) return;

    isLoading.value = true;

    try {
      await Future.delayed(Duration(milliseconds: 1500));

      final response = await http.post(
        Uri.parse('$supabaseUrl/auth/v1/token?grant_type=password'),
        headers: {'Content-Type': 'application/json', 'apikey': supabaseAPIKey},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      final body = jsonDecode(response.body);
      if (response.statusCode == 200 && body['access_token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', body['access_token']);
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.home);
      } else {
        throw body['error_description'] ?? body['msg'] ?? 'Login failed';
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackbar.showError('Login Error', e.toString());
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
