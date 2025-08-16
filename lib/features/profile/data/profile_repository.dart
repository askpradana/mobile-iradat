import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/notification_service.dart';
import '../../auth/models.dart' as auth_models;
import '../models.dart';

class ProfileRepository {
  final ApiClient api;
  final FlutterSecureStorage secureStorage;

  ProfileRepository(this.api, this.secureStorage);

  Future<auth_models.User?> getProfile() async {
    try {
      final response = await api.get('/profile');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = auth_models.User.fromJson(data['data']['user'] ?? {});
        
        // Update cached user data in auth storage
        await secureStorage.write(key: 'user', value: jsonEncode(user.toJson()));
        return user;
      } else {
        NotificationService.showError(
          'Profile Error', 
          'Failed to load profile data'
        );
      }
      return null;
    } catch (e) {
      // Try to return cached data if available
      final cachedUser = await getCachedProfile();
      if (cachedUser == null) {
        NotificationService.showError(
          'Network Error', 
          'Please check your internet connection'
        );
      }
      return cachedUser;
    }
  }

  Future<auth_models.User?> getCachedProfile() async {
    try {
      final userJson = await secureStorage.read(key: 'user');
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        return auth_models.User.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<auth_models.User?> updateProfile(ProfileUpdate updateData) async {
    try {
      if (!updateData.hasData) {
        NotificationService.showWarning(
          'No Changes', 
          'Please make at least one change before saving.'
        );
        return null;
      }

      final response = await api.put('/profile', updateData.toJson());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = auth_models.User.fromJson(data['data']['user'] ?? {});
        
        // Update cached user data
        await secureStorage.write(key: 'user', value: jsonEncode(user.toJson()));
        
        NotificationService.showSuccess(
          'Success', 
          'Profile updated successfully!'
        );
        return user;
      } else {
        final errorData = jsonDecode(response.body);
        NotificationService.showError(
          'Update Failed', 
          errorData['message'] ?? 'Failed to update profile'
        );
      }
      return null;
    } catch (e) {
      NotificationService.showError(
        'Network Error', 
        'Please check your internet connection'
      );
      return null;
    }
  }

  Future<void> clearProfile() async {
    try {
      await secureStorage.delete(key: 'profile');
    } catch (e) {
      // Ignore errors when clearing
    }
  }
}