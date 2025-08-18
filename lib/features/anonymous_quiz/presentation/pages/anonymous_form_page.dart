import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anonymous_quiz_controller.dart';

class AnonymousFormPage extends StatelessWidget {
  const AnonymousFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnonymousQuizController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Information'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: controller.backToCode,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.userFormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 32),
                  _buildNameField(controller),
                  const SizedBox(height: 16),
                  _buildEmailField(controller),
                  const SizedBox(height: 16),
                  _buildPhoneField(controller),
                  const SizedBox(height: 16),
                  _buildOrganizationField(controller),
                  const SizedBox(height: 32),
                  _buildContinueButton(controller),
                  const SizedBox(height: 16),
                  _buildBackButton(controller),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.assignment_ind_outlined,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Personal Information',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please provide your information to access the quiz.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildNameField(AnonymousQuizController controller) {
    return TextFormField(
      controller: controller.nameController,
      keyboardType: TextInputType.name,
      validator: controller.validateName,
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: 'Enter your full name',
        prefixIcon: const Icon(Icons.person_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(Get.context!).colorScheme.surface,
      ),
    );
  }

  Widget _buildEmailField(AnonymousQuizController controller) {
    return TextFormField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: controller.validateEmail,
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'Enter your email address',
        prefixIcon: const Icon(Icons.email_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(Get.context!).colorScheme.surface,
      ),
    );
  }

  Widget _buildPhoneField(AnonymousQuizController controller) {
    return TextFormField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      validator: controller.validatePhone,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter your phone number',
        prefixIcon: const Icon(Icons.phone_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(Get.context!).colorScheme.surface,
      ),
    );
  }

  Widget _buildOrganizationField(AnonymousQuizController controller) {
    return TextFormField(
      controller: controller.organizationController,
      keyboardType: TextInputType.text,
      validator: controller.validateOrganization,
      decoration: InputDecoration(
        labelText: 'Organization',
        hintText: 'Enter your organization name',
        prefixIcon: const Icon(Icons.business_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(Get.context!).colorScheme.surface,
      ),
    );
  }

  Widget _buildContinueButton(AnonymousQuizController controller) {
    return Obx(() => ElevatedButton(
      onPressed: controller.isRegistering.value ? null : controller.registerAnonymousUser,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: controller.isRegistering.value
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(
              'Continue to Quiz',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
    ));
  }

  Widget _buildBackButton(AnonymousQuizController controller) {
    return TextButton(
      onPressed: controller.backToCode,
      child: Text(
        'Back to Code Entry',
        style: Theme.of(Get.context!).textTheme.titleSmall?.copyWith(
          color: Theme.of(Get.context!).colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}