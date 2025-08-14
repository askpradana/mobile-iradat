import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../presentation/controllers/base_controller.dart';
import '../../../../domain/usecases/login_usecase.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../settings/route_management.dart';

class LoginController extends BaseController {
  final LoginUseCase loginUseCase;
  
  LoginController({required this.loginUseCase});
  
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordVisible = false.obs;
  
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  
  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    if (isLoading.value) return;
    
    LoggerService.info('Attempting login for user: ${emailController.text}');
    setLoading(true);
    clearError();
    
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      
      final result = await loginUseCase(LoginParams(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));
      
      result.fold(
        (failure) {
          LoggerService.error('Login failed: ${failure.message}');
          handleFailure(failure);
          showErrorSnackbar('Login Error', failure.message);
        },
        (user) {
          LoggerService.success('Login successful for user: ${user.email}');
          showSuccessSnackbar('Success', 'Login successful!');
          Get.offAllNamed(AppRoutes.home);
        },
      );
    } finally {
      setLoading(false);
    }
  }
  
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
  
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}