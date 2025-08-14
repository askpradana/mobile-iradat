import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/profile_model.dart';
import '../../../data/datasources/profile_remote_data_source.dart';
import '../../../core/services/auth_storage_service.dart';
import '../../../widgets/snackbars.dart';

class ProfileController extends GetxController {
  final ProfileRemoteDataSource _profileDataSource = ProfileRemoteDataSource();
  
  // Form controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final avatarController = TextEditingController();

  // State management
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isEditing = false.obs;
  final profile = Rx<ProfileModel?>(null);
  final originalProfile = Rx<ProfileModel?>(null);
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
      final originalData = originalProfile.value!;
      hasUnsavedChanges.value = (
        nameController.text.trim() != originalData.name ||
        emailController.text.trim() != (originalData.email ?? '') ||
        phoneController.text.trim() != (originalData.phone ?? '') ||
        dobController.text.trim() != (originalData.dateOfBirth ?? '') ||
        avatarController.text.trim() != (originalData.avatarPicture ?? '')
      );
    }
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      
      // Try to load from cache first
      final cachedProfile = await AuthStorageService.getProfileData();
      if (cachedProfile != null) {
        _updateProfileData(cachedProfile);
      }
      
      // Then fetch from API
      final profileResponse = await _profileDataSource.getProfile();
      _updateProfileData(profileResponse.data);
      
      // Cache the new data
      await AuthStorageService.storeProfileData(profileResponse.data);
    } catch (e) {
      CustomSnackbar.showError('Error', e.toString());
      
      // If API fails, try to use cached data
      final cachedProfile = await AuthStorageService.getProfileData();
      if (cachedProfile != null) {
        _updateProfileData(cachedProfile);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _updateProfileData(ProfileModel profileData) {
    profile.value = profileData;
    originalProfile.value = profileData;
    
    // Update form controllers
    nameController.text = profileData.name;
    emailController.text = profileData.email ?? '';
    phoneController.text = profileData.phone ?? '';
    dobController.text = profileData.dateOfBirth ?? '';
    avatarController.text = profileData.avatarPicture ?? '';
    
    hasUnsavedChanges.value = false;
  }

  void toggleEdit() {
    if (isEditing.value) {
      // Cancel edit - reset form to original values
      if (originalProfile.value != null) {
        _updateProfileData(originalProfile.value!);
      }
    }
    isEditing.toggle();
  }

  Future<void> saveProfile() async {
    if (!hasUnsavedChanges.value) {
      CustomSnackbar.showError('No Changes', 'Please make at least one change before saving.');
      return;
    }

    try {
      isSaving.value = true;
      
      final updateData = ProfileUpdateModel(
        name: nameController.text.trim().isNotEmpty ? nameController.text.trim() : null,
        email: emailController.text.trim().isNotEmpty ? emailController.text.trim() : null,
        phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
        dateOfBirth: dobController.text.trim().isNotEmpty ? dobController.text.trim() : null,
        avatarPicture: avatarController.text.trim().isNotEmpty ? avatarController.text.trim() : null,
      );
      
      final profileResponse = await _profileDataSource.updateProfile(updateData);
      _updateProfileData(profileResponse.data);
      
      // Update cached data
      await AuthStorageService.storeProfileData(profileResponse.data);
      
      isEditing.value = false;
      CustomSnackbar.showSuccess('Success', 'Profile updated successfully!');
    } catch (e) {
      CustomSnackbar.showError('Update Failed', e.toString());
    } finally {
      isSaving.value = false;
    }
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

  bool get hasProfileData => profile.value != null;
  
  String get displayName => profile.value?.name ?? 'Loading...';
  
  String get displayEmail => profile.value?.email ?? '';
  
  String get displayPhone => profile.value?.phone ?? '';
  
  String get displayDob => profile.value?.dateOfBirth ?? '';
  
  String get displayAvatar => profile.value?.avatarPicture ?? '';
  
  bool get hasAvatar => profile.value?.avatarPicture?.isNotEmpty == true;
  
  LastAnalyzedModel? get lastAnalyzed => profile.value?.lastAnalyzed;
  
  Map<String, dynamic>? get iproData => profile.value?.ipro;
  
  Map<String, dynamic>? get iprobData => profile.value?.iprob;
  
  Map<String, dynamic>? get iprosData => profile.value?.ipros;

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