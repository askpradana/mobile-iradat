import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/notification_service.dart';
import '../models.dart';

class AuthRepository {
  final ApiClient api;
  final FlutterSecureStorage secureStorage;

  AuthRepository(this.api, this.secureStorage);

  Future<LoginResponse?> login(String email, String password) async {
    try {
      final response = await api.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final loginResponse = LoginResponse.fromJson(jsonData);
        
        if (loginResponse.success) {
          // Store token and user data
          await secureStorage.write(
            key: 'accessToken',
            value: loginResponse.data.token,
          );
          await secureStorage.write(
            key: 'expiresAt',
            value: loginResponse.data.expiresAt,
          );
          await secureStorage.write(
            key: 'user',
            value: jsonEncode(loginResponse.data.user.toJson()),
          );
          await secureStorage.write(
            key: 'services',
            value: jsonEncode(loginResponse.data.services.map((s) => {
              'code': s.code,
              'name': s.name,
              'icon_url': s.iconUrl,
              'redirect_to': s.redirectTo,
              'created_at': s.createdAt,
              'updated_at': s.updatedAt,
            }).toList()),
          );
          
          NotificationService.showSuccess('Success', loginResponse.message);
          return loginResponse;
        } else {
          NotificationService.showError('Login Failed', loginResponse.message);
          return null;
        }
      } else {
        final errorData = jsonDecode(response.body);
        NotificationService.showError(
          'Login Failed', 
          errorData['message'] ?? 'Invalid credentials'
        );
        return null;
      }
    } catch (e) {
      NotificationService.showError(
        'Network Error', 
        'Please check your internet connection and try again'
      );
      return null;
    }
  }

  Future<RegisterResponse?> register(
    String email,
    String name,
    String password,
    String phone,
  ) async {
    try {
      final response = await api.post('/auth/register', {
        'email': email,
        'name': name,
        'password': password,
        'phone': phone,
      });

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final registerResponse = RegisterResponse.fromJson(jsonData);
        
        if (registerResponse.success) {
          NotificationService.showSuccess('Success', registerResponse.message);
          return registerResponse;
        } else {
          NotificationService.showError('Registration Failed', registerResponse.message);
          return null;
        }
      } else {
        final errorData = jsonDecode(response.body);
        NotificationService.showError(
          'Registration Failed', 
          errorData['message'] ?? 'Registration failed. Please try again.'
        );
        return null;
      }
    } catch (e) {
      NotificationService.showError(
        'Network Error', 
        'Please check your internet connection and try again'
      );
      return null;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await api.post('/auth/logout', {});
      
      if (response.statusCode == 200) {
        await secureStorage.deleteAll();
        NotificationService.showInfo('Logout', 'You have been logged out successfully');
        return true;
      } else if (response.statusCode == 401) {
        // Token expired or invalid, clear storage anyway
        await secureStorage.deleteAll();
        NotificationService.showWarning('Session Expired', 'Please login again');
        return true;
      } else {
        NotificationService.showError('Logout Failed', 'Unable to logout. Please try again.');
        return false;
      }
    } catch (e) {
      // Network error, clear storage anyway for local logout
      await secureStorage.deleteAll();
      NotificationService.showWarning(
        'Offline Logout', 
        'Logged out locally. Please check your connection.'
      );
      return true;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await secureStorage.read(key: 'accessToken');
      final expiresAt = await secureStorage.read(key: 'expiresAt');
      
      if (token != null && expiresAt != null) {
        final expiry = DateTime.parse(expiresAt);
        return DateTime.now().isBefore(expiry);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final userJson = await secureStorage.read(key: 'user');
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        return User.fromJson(userData);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAuthToken() async {
    try {
      return await secureStorage.read(key: 'accessToken');
    } catch (e) {
      return null;
    }
  }

  Future<List<Service>> getServices() async {
    try {
      final servicesJson = await secureStorage.read(key: 'services');
      if (servicesJson != null) {
        final servicesList = jsonDecode(servicesJson) as List<dynamic>;
        return servicesList.map((service) => Service.fromJson(service)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
