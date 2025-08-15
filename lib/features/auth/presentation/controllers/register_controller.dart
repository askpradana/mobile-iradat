import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../presentation/controllers/base_controller.dart';
import '../../../../domain/usecases/register_usecase.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../widgets/snackbars.dart';
import '../../../../screens/auth/login/login_view.dart';

class RegisterController extends BaseController {
  final RegisterUseCase registerUseCase;
  
  RegisterController({required this.registerUseCase});
  
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final isPasswordVisible = false.obs;
  
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  
  Future<void> handleRegister() async {
    if (!formKey.currentState!.validate()) return;
    if (isLoading.value) return;
    
    LoggerService.info('Attempting registration for user: ${emailController.text}');
    setLoading(true);
    clearError();
    
    try {
      final result = await registerUseCase(RegisterParams(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
        phone: phoneController.text.trim(),
      ));
      
      result.fold(
        (failure) {
          LoggerService.error('Registration failed: ${failure.message}');
          handleFailure(failure);
          CustomSnackbar.showError('Registration Error', failure.message);
        },
        (_) {
          LoggerService.success('Registration successful for user: ${emailController.text}');
          Get.off(() => const LoginView());
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
  
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
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
  
  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  
  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}