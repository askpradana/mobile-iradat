import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          Obx(() => IconButton(
            icon: Icon(
              controller.isEditing.value ? Icons.close : Icons.edit,
              color: Colors.black87,
            ),
            onPressed: controller.toggleEdit,
          )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                _buildProfileCard(controller),
                const SizedBox(height: 24),
                _buildProfileForm(controller),
                if (controller.isEditing.value) ...[
                  const SizedBox(height: 24),
                  _buildSaveButton(controller),
                ],
                if (controller.lastAnalyzedData != null && controller.lastAnalyzedData!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildLastAnalysisCard(controller),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildProfileCard(ProfileController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.1),
              backgroundImage: controller.hasAvatar
                  ? NetworkImage(controller.displayAvatar)
                  : null,
              child: !controller.hasAvatar
                  ? Text(
                      controller.userInitials,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.primary,
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 16),
            Text(
              controller.displayName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (controller.displayEmail.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                controller.displayEmail,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProfileForm(ProfileController controller) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Profile Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: controller.nameController,
              label: 'Full Name',
              icon: Icons.person_outline,
              enabled: controller.isEditing.value,
              validator: controller.validateName,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: controller.emailController,
              label: 'Email',
              icon: Icons.email_outlined,
              enabled: controller.isEditing.value,
              validator: controller.validateEmail,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: controller.phoneController,
              label: 'Phone Number',
              icon: Icons.phone_outlined,
              enabled: controller.isEditing.value,
              validator: controller.validatePhone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: controller.dobController,
              label: 'Date of Birth',
              icon: Icons.calendar_today_outlined,
              enabled: controller.isEditing.value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool enabled = true,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: !enabled,
        fillColor: !enabled ? Colors.grey[100] : null,
      ),
    );
  }

  Widget _buildSaveButton(ProfileController controller) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() => ElevatedButton(
        onPressed: controller.isSaving.value ? null : controller.saveProfile,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: controller.isSaving.value
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Save Changes',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
      )),
    );
  }

  Widget _buildLastAnalysisCard(ProfileController controller) {
    final lastAnalyzedData = controller.lastAnalyzedData!;
    final lastAnalyzedType = lastAnalyzedData['last_analyzed'] as String? ?? 'Analysis';
    final analyzedAt = lastAnalyzedData['analyzed_at'] as String? ?? '';
    final comment = lastAnalyzedData['comment'] as String? ?? '';
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Analysis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.psychology_outlined,
                  color: Get.theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lastAnalyzedType.isNotEmpty 
                            ? lastAnalyzedType 
                            : 'Psychological Analysis',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      if (analyzedAt.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          analyzedAt,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                      if (comment.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          comment,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}