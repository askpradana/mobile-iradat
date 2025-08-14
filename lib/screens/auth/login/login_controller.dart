import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_iradat/core/services/auth_storage_service.dart';
import 'package:quiz_iradat/data/models/login_response_model.dart';
import 'package:quiz_iradat/settings/route_management.dart';
import 'package:quiz_iradat/settings/supabase.dart';
import 'package:quiz_iradat/widgets/snackbars.dart';

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
        Uri.parse('$backendBaseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      final body = jsonDecode(response.body);
      
      if (response.statusCode == 200) {
        final loginResponse = LoginResponseModel.fromJson(body);
        
        if (loginResponse.success) {
          // Store authentication data securely
          await _storeAuthData(loginResponse.data);
          
          isLoading.value = false;
          Get.offAllNamed(AppRoutes.home);
        } else {
          throw loginResponse.message;
        }
      } else {
        // Handle API errors
        if (body is Map<String, dynamic>) {
          throw body['message'] ?? body['error'] ?? 'Login failed';
        } else {
          throw 'Login failed with status code: ${response.statusCode}';
        }
      }
    } catch (e) {
      isLoading.value = false;
      CustomSnackbar.showError('Login Error', e.toString());
    }
  }
  
  Future<void> _storeAuthData(LoginDataModel loginData) async {
    try {
      // Store authentication data using the auth storage service
      await AuthStorageService.storeAuthToken(loginData.token);
      await AuthStorageService.storeUserData(loginData.user);
      await AuthStorageService.storeServicesData(loginData.services);
    } catch (e) {
      throw 'Failed to store authentication data: $e';
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
