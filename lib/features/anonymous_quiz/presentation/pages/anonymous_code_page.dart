import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/anonymous_quiz_controller.dart';

class AnonymousCodePage extends StatelessWidget {
  const AnonymousCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AnonymousQuizController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.codeFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                const SizedBox(height: 48),
                _buildCodeField(controller),
                const SizedBox(height: 32),
                _buildValidateButton(controller),
                const SizedBox(height: 16),
                _buildBackButton(context),
              ],
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
          Icons.key,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 16),
        Text(
          'Enter Invitation Code',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please enter your invitation code to access the quiz.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCodeField(AnonymousQuizController controller) {
    return TextFormField(
      controller: controller.referralCodeController,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.characters,
      validator: controller.validateReferralCodeInput,
      decoration: InputDecoration(
        labelText: 'Invitation Code',
        hintText: 'e.g., D21IR',
        prefixIcon: const Icon(Icons.confirmation_number_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Theme.of(Get.context!).colorScheme.surface,
      ),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildValidateButton(AnonymousQuizController controller) {
    return Obx(() => ElevatedButton(
      onPressed: controller.isValidating.value ? null : controller.validateReferralCode,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: controller.isValidating.value
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : const Text(
              'Validate Code',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
    ));
  }

  Widget _buildBackButton(BuildContext context) {
    return TextButton(
      onPressed: () => Get.back(),
      child: Text(
        'Back to Login',
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}