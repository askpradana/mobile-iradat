import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/auth_repository.dart';
import '../../models.dart';

class AuthController extends GetxController {
  final AuthRepository repo;

  AuthController(this.repo);

  final isLoading = false.obs;
  final user = Rxn<User>();
  final isPasswordVisible = false.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    isLoading.value = true;
    final isLoggedIn = await repo.isLoggedIn();
    if (isLoggedIn) {
      final currentUser = await repo.getCurrentUser();
      if (currentUser != null) {
        user.value = currentUser;
        Get.offAllNamed('/home');
      }
    }
    isLoading.value = false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await repo.login(email, password);
    isLoading.value = false;

    if (result != null && result.success) {
      user.value = result.data.user;
      Get.offAllNamed('/home');
    }
    // Error notification is handled in repository
  }

  Future<void> handleLogin() async {
    if (!formKey.currentState!.validate()) return;
    if (isLoading.value) return;

    await login(emailController.text.trim(), passwordController.text.trim());
  }

  Future<void> register(String email, String name, String password, String phone) async {
    isLoading.value = true;
    final result = await repo.register(email, name, password, phone);
    isLoading.value = false;

    if (result != null && result.success) {
      // Clear form fields
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneController.clear();
      
      Get.offAllNamed('/login');
    }
    // Error notification is handled in repository
  }

  Future<void> handleRegister() async {
    if (!formKey.currentState!.validate()) return;
    if (isLoading.value) return;

    await register(
      emailController.text.trim(),
      nameController.text.trim(),
      passwordController.text.trim(),
      phoneController.text.trim(),
    );
  }

  Future<void> logout() async {
    final success = await repo.logout();
    if (success) {
      user.value = null;
      Get.offAllNamed('/onboarding');
    }
    // Notification is handled in repository
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    if (value.length < 10) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}