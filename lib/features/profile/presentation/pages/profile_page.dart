import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/date_picker_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(controller.isEditing.value ? Icons.close : Icons.edit),
              onPressed: controller.toggleEdit,
            ),
          ),
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
                if (controller.lastAnalyzedData != null &&
                    controller.lastAnalyzedData!.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildLastAnalysisCard(controller),
                ],
                if (controller.hasAssessmentData) ...[
                  const SizedBox(height: 24),
                  _buildAssessmentDataSection(controller),
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
              backgroundColor: Get.theme.colorScheme.primary.withValues(
                alpha: 0.1,
              ),
              backgroundImage:
                  controller.hasAvatar
                      ? NetworkImage(controller.displayAvatar)
                      : null,
              child:
                  !controller.hasAvatar
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (controller.displayEmail.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                controller.displayEmail,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
            // Show age if date of birth is available
            Obx(() {
              final age = controller.profileAge;
              if (age != null) {
                return Column(
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      'Age: $age years old',
                      style: TextStyle(
                        fontSize: 14, 
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            Obx(() => DatePickerFormField(
              initialValue: controller.selectedDateOfBirth.value,
              onDateSelected: controller.selectDateOfBirth,
              label: 'Date of Birth',
              icon: Icons.calendar_today_outlined,
              enabled: controller.isEditing.value,
              validator: controller.validateDateOfBirth,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool enabled,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Builder(
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return TextFormField(
          controller: controller,
          enabled: enabled,
          validator: validator,
          keyboardType: keyboardType,
          style: TextStyle(color: colorScheme.onSurface), // text color
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
            prefixIcon: Icon(icon, color: colorScheme.primary),
            filled: true,
            fillColor:
                enabled
                    ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
                    : colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.15,
                    ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary, width: 2),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSaveButton(ProfileController controller) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          onPressed: controller.isSaving.value ? null : controller.saveProfile,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child:
              controller.isSaving.value
                  ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
        ),
      ),
    );
  }

  Widget _buildLastAnalysisCard(ProfileController controller) {
    final lastAnalyzedData = controller.lastAnalyzedData!;
    final lastAnalyzedType =
        lastAnalyzedData['last_analyzed'] as String? ?? 'Analysis';
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
            Row(
              children: [
                Icon(
                  Icons.psychology_outlined,
                  color: Get.theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Last Analysis',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lastAnalyzedType.isNotEmpty
                        ? _formatAnalysisType(lastAnalyzedType)
                        : 'Psychological Analysis',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  if (analyzedAt.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Analyzed on: $analyzedAt',
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
      ),
    );
  }

  Widget _buildAssessmentDataSection(ProfileController controller) {
    return Column(
      children: [
        if (controller.hasIproData) ..._buildAssessmentCard(
          'IPRO Assessment',
          'Individual Personality & Responsibility Orientation',
          Icons.person_outline,
          controller.iproData!,
          Get.theme.colorScheme.primary,
        ),
        if (controller.hasIprobData) ...[
          if (controller.hasIproData) const SizedBox(height: 16),
          ..._buildAssessmentCard(
            'IPROB Assessment',
            'Individual Personality & Responsibility Organization Behavior',
            Icons.groups_outlined,
            controller.iprobData!,
            Get.theme.colorScheme.secondary,
          ),
        ],
        if (controller.hasIprosData) ...[
          if (controller.hasIproData || controller.hasIprobData) const SizedBox(height: 16),
          ..._buildAssessmentCard(
            'IPROS Assessment',
            'Individual Personality & Responsibility Organization Social',
            Icons.psychology_outlined,
            controller.iprosData!,
            Get.theme.colorScheme.tertiary,
          ),
        ],
      ],
    );
  }

  List<Widget> _buildAssessmentCard(
    String title,
    String subtitle,
    IconData icon,
    Map<String, dynamic> data,
    Color accentColor,
  ) {
    return [
      Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: accentColor,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildAssessmentItems(data, accentColor),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildAssessmentItems(Map<String, dynamic> data, Color accentColor) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: data.entries.map((entry) {
        return _buildAssessmentChip(
          _formatKey(entry.key),
          entry.value.toString(),
          accentColor,
        );
      }).toList(),
    );
  }

  Widget _buildAssessmentChip(String key, String value, Color accentColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            key,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: accentColor.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    // Convert camelCase and snake_case to Title Case
    return key
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) => '${match[1]} ${match[2]}')
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '')
        .join(' ');
  }

  String _formatAnalysisType(String type) {
    switch (type.toLowerCase()) {
      case 'depression':
        return 'Depression Assessment';
      case 'anxiety':
        return 'Anxiety Assessment';
      case 'stress':
        return 'Stress Assessment';
      case 'dass21':
        return 'DASS-21 Assessment';
      case 'srq20':
        return 'SRQ-20 Assessment';
      case 'smfa10':
        return 'SMFA-10 Assessment';
      default:
        return type.split(' ').map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}' : '').join(' ');
    }
  }
}
