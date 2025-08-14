import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/profile_model.dart';
import 'profile_controller.dart';

class ProfilesettingsView extends StatelessWidget {
  const ProfilesettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
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
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Avatar and Name Card
                  _buildProfileCard(controller),
                  const SizedBox(height: 24),
                  // Psychological Analysis Cards (if available)
                  if (controller.lastAnalyzed != null) ..._buildAnalysisCards(controller),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildProfileCard(ProfileController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar - Now Reactive
          Obx(() => controller.hasAvatar
              ? CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(controller.displayAvatar),
                  onBackgroundImageError: (_, __) => const Icon(Icons.person),
                )
              : CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.blue.withValues(alpha: 0.1),
                  child: Text(
                    controller.userInitials,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 2,
                    ),
                  ),
                ),
          ),
          const SizedBox(height: 16),
          // Name - Now Reactive
          Obx(() => Text(
            controller.displayName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          )),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Name Field - Now included
                Obx(
                  () => TextFormField(
                    controller: controller.nameController,
                    enabled: controller.isEditing.value,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor:
                          controller.isEditing.value
                              ? Colors.white
                              : Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    controller: controller.emailController,
                    enabled: controller.isEditing.value,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor:
                          controller.isEditing.value
                              ? Colors.white
                              : Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    controller: controller.phoneController,
                    enabled: controller.isEditing.value,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor:
                          controller.isEditing.value
                              ? Colors.white
                              : Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => TextFormField(
                    controller: controller.dobController,
                    enabled: controller.isEditing.value,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      prefixIcon: const Icon(Icons.cake_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor:
                          controller.isEditing.value
                              ? Colors.white
                              : Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Avatar URL Field
                Obx(
                  () => TextFormField(
                    controller: controller.avatarController,
                    enabled: controller.isEditing.value,
                    decoration: InputDecoration(
                      labelText: 'Avatar URL',
                      prefixIcon: const Icon(Icons.image_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor:
                          controller.isEditing.value
                              ? Colors.white
                              : Colors.grey[100],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Action Buttons with Loading State
                Obx(
                  () => controller.isSaving.value
                      ? const SizedBox(
                          height: 50,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : controller.isEditing.value
                          ? Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: controller.toggleEdit,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[600],
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        elevation: 3,
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.cancel,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: Obx(
                                      () => ElevatedButton(
                                        onPressed: controller.hasUnsavedChanges.value
                                            ? controller.saveProfile
                                            : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.green[600],
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          elevation: 3,
                                        ),
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.save,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              'Save',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: controller.toggleEdit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  elevation: 3,
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit, color: Colors.white),
                                    SizedBox(width: 8),
                                    Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAnalysisCards(ProfileController controller) {
    final widgets = <Widget>[];
    
    // Last Analysis Card
    if (controller.lastAnalyzed != null) {
      widgets.addAll([
        _buildLastAnalysisCard(controller.lastAnalyzed!),
        const SizedBox(height: 24),
      ]);
    }
    
    // Psychological Analysis Tables
    if (controller.iproData?.isNotEmpty == true) {
      widgets.addAll([
        _buildTraitTable('IPRO Analysis', controller.iproData!),
        const SizedBox(height: 16),
      ]);
    }
    
    if (controller.iprobData?.isNotEmpty == true) {
      widgets.addAll([
        _buildTraitTable('IPROB Analysis', controller.iprobData!),
        const SizedBox(height: 16),
      ]);
    }
    
    if (controller.iprosData?.isNotEmpty == true) {
      widgets.addAll([
        _buildTraitTable('IPROS Analysis', controller.iprosData!),
      ]);
    }
    
    return widgets;
  }

  Widget _buildLastAnalysisCard(LastAnalyzedModel lastAnalyzed) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  color: Colors.blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Last Analysis',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Analysis Type: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      lastAnalyzed.displayTitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text(
                    'Date: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    lastAnalyzed.formattedDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Analysis Comment:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lastAnalyzed.comment,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTraitTable(String title, Map<String, dynamic> traits) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              },
              children: [
                const TableRow(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                  ),
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Trait',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Value',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                ...traits.entries.map((entry) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        _formatTraitName(entry.key),
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        entry.value.toString(),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                )).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTraitName(String name) {
    return name.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ');
  }
}