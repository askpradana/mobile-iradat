import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../data/models/user_model.dart';
import '../../data/models/service_model.dart';
import '../../data/models/profile_model.dart';

class AuthStorageService {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Storage keys
  static const String _authTokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';
  static const String _servicesDataKey = 'services_data';
  static const String _profileDataKey = 'profile_data';

  /// Get stored authentication token
  static Future<String?> getAuthToken() async {
    return await _secureStorage.read(key: _authTokenKey);
  }

  /// Get stored user data as UserModel
  static Future<UserModel?> getUserData() async {
    final userData = await _secureStorage.read(key: _userDataKey);
    if (userData != null) {
      final json = jsonDecode(userData) as Map<String, dynamic>;
      return UserModel.fromJson(json);
    }
    return null;
  }

  /// Get stored services data as List ServiceModel
  static Future<List<ServiceModel>?> getServicesData() async {
    final servicesData = await _secureStorage.read(key: _servicesDataKey);
    if (servicesData != null) {
      final decoded = jsonDecode(servicesData) as List<dynamic>;
      return decoded
          .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return null;
  }

  /// Store authentication token
  static Future<void> storeAuthToken(String token) async {
    await _secureStorage.write(key: _authTokenKey, value: token);
  }

  /// Store user data
  static Future<void> storeUserData(UserModel user) async {
    await _secureStorage.write(
      key: _userDataKey,
      value: jsonEncode(user.toJson()),
    );
  }

  /// Store services data
  static Future<void> storeServicesData(List<ServiceModel> services) async {
    await _secureStorage.write(
      key: _servicesDataKey,
      value: jsonEncode(services.map((s) => s.toJson()).toList()),
    );
  }

  /// Check if user is authenticated (has valid token)
  static Future<bool> isAuthenticated() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  /// Get stored profile data as ProfileModel
  static Future<ProfileModel?> getProfileData() async {
    final profileData = await _secureStorage.read(key: _profileDataKey);
    if (profileData != null) {
      final json = jsonDecode(profileData) as Map<String, dynamic>;
      return ProfileModel.fromJson(json);
    }
    return null;
  }

  /// Store profile data
  static Future<void> storeProfileData(ProfileModel profile) async {
    await _secureStorage.write(
      key: _profileDataKey,
      value: jsonEncode(profile.toJson()),
    );
  }

  /// Clear all authentication data
  static Future<void> clearAuthData() async {
    await _secureStorage.delete(key: _authTokenKey);
    await _secureStorage.delete(key: _userDataKey);
    await _secureStorage.delete(key: _servicesDataKey);
    await _secureStorage.delete(key: _profileDataKey);
  }

  /// Clear all stored data
  static Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
