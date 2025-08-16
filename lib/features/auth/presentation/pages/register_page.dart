import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildNameField(controller),
                const SizedBox(height: 16),
                _buildEmailField(controller),
                const SizedBox(height: 16),
                _buildPhoneField(controller),
                const SizedBox(height: 16),
                _buildPasswordField(controller),
                const SizedBox(height: 32),
                _buildRegisterButton(controller),
                const SizedBox(height: 16),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.person_add_outlined,
          size: 80,
          color: Get.theme.colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Create Account',
          style: Get.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Get.theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Join us to start your mental health journey.',
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameField(AuthController controller) {
    return TextFormField(
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      validator: controller.validateName,
      decoration: InputDecoration(
        labelText: 'Full Name',
        prefixIcon: const Icon(Icons.person_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildEmailField(AuthController controller) {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: controller.validateEmail,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildPhoneField(AuthController controller) {
    return TextFormField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      validator: controller.validatePhone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        prefixIcon: const Icon(Icons.phone_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _buildPasswordField(AuthController controller) {
    return Obx(() => TextFormField(
      controller: controller.passwordController,
      obscureText: !controller.isPasswordVisible.value,
      validator: controller.validatePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock_outlined),
        suffixIcon: IconButton(
          icon: Icon(
            controller.isPasswordVisible.value
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: controller.togglePasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ));
  }

  Widget _buildRegisterButton(AuthController controller) {
    return Obx(() => ElevatedButton(
      onPressed: controller.isLoading.value ? null : controller.handleRegister,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: controller.isLoading.value
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(
              'Register',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
    ));
  }

  Widget _buildLoginButton() {
    return TextButton(
      onPressed: () => Get.back(),
      child: Text(
        'Already have an account? Login',
        style: TextStyle(
          color: Get.theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}