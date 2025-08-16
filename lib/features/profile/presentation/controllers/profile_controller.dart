import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/profile_repository.dart';
import '../../../auth/models.dart' as auth_models;
import '../../models.dart';

class ProfileController extends GetxController {
  final ProfileRepository repo;

  ProfileController(this.repo);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final avatarController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isEditing = false.obs;
  final profile = Rxn<auth_models.User>();
  final originalProfile = Rxn<auth_models.User>();
  final hasUnsavedChanges = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    _setupChangeListeners();
  }

  void _setupChangeListeners() {
    nameController.addListener(_checkForChanges);
    emailController.addListener(_checkForChanges);
    phoneController.addListener(_checkForChanges);
    dobController.addListener(_checkForChanges);
    avatarController.addListener(_checkForChanges);
  }

  void _checkForChanges() {
    if (originalProfile.value != null) {
      final original = originalProfile.value!;
      hasUnsavedChanges.value = (
        nameController.text.trim() != original.name ||
        emailController.text.trim() != original.email ||
        phoneController.text.trim() != original.phone ||
        dobController.text.trim() != (original.dateOfBirth ?? '') ||
        avatarController.text.trim() != (original.avatarPicture ?? '')
      );
    }
  }

  Future<void> loadProfile() async {
    isLoading.value = true;
    
    // Try to load cached profile first
    final cachedProfile = await repo.getCachedProfile();
    if (cachedProfile != null) {
      _updateProfileData(cachedProfile);
    }
    
    // Then fetch from API
    final fetchedProfile = await repo.getProfile();
    if (fetchedProfile != null) {
      _updateProfileData(fetchedProfile);
    }
    
    isLoading.value = false;
  }

  void _updateProfileData(auth_models.User userData) {
    profile.value = userData;
    originalProfile.value = userData;
    
    nameController.text = userData.name;
    emailController.text = userData.email;
    phoneController.text = userData.phone;
    dobController.text = userData.dateOfBirth ?? '';
    avatarController.text = userData.avatarPicture ?? '';
    
    hasUnsavedChanges.value = false;
  }

  void toggleEdit() {
    if (isEditing.value) {
      if (originalProfile.value != null) {
        _updateProfileData(originalProfile.value!);
      }
    }
    isEditing.toggle();
  }

  Future<void> saveProfile() async {
    if (!hasUnsavedChanges.value) {
      return;
    }

    if (!formKey.currentState!.validate()) return;

    isSaving.value = true;
    
    final updateData = ProfileUpdate(
      name: nameController.text.trim().isNotEmpty ? nameController.text.trim() : null,
      email: emailController.text.trim().isNotEmpty ? emailController.text.trim() : null,
      phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
      dateOfBirth: dobController.text.trim().isNotEmpty ? dobController.text.trim() : null,
      avatarPicture: avatarController.text.trim().isNotEmpty ? avatarController.text.trim() : null,
    );
    
    final updatedProfile = await repo.updateProfile(updateData);
    isSaving.value = false;
    
    if (updatedProfile != null) {
      _updateProfileData(updatedProfile);
      isEditing.value = false;
    }
    // Notifications are handled in repository
  }

  String get userInitials {
    if (profile.value?.name.isNotEmpty == true) {
      final nameParts = profile.value!.name.split(' ');
      if (nameParts.length >= 2) {
        return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
      } else {
        return profile.value!.name.length >= 2 
            ? profile.value!.name.substring(0, 2).toUpperCase()
            : profile.value!.name.toUpperCase();
      }
    }
    return 'UN';
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (!GetUtils.isEmail(value.trim())) {
        return 'Please enter a valid email';
      }
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      if (value.trim().length < 10) {
        return 'Please enter a valid phone number';
      }
    }
    return null;
  }

  bool get hasProfileData => profile.value != null;
  String get displayName => profile.value?.name ?? 'Loading...';
  String get displayEmail => profile.value?.email ?? '';
  String get displayPhone => profile.value?.phone ?? '';
  String get displayDob => profile.value?.dateOfBirth ?? '';
  String get displayAvatar => profile.value?.avatarPicture ?? '';
  bool get hasAvatar => profile.value?.avatarPicture?.isNotEmpty == true;
  
  Map<String, dynamic>? get lastAnalyzedData => profile.value?.lastAnalyzed;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    avatarController.dispose();
    super.onClose();
  }
}