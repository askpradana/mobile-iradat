import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../../core/errors/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> getCachedUser();
  Future<void> cacheUser(UserModel user);
  Future<void> clearUser();
  Future<String?> getAuthToken();
  Future<void> saveAuthToken(String token);
  Future<void> clearAuthToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  
  static const String cachedUserKey = 'user_data';
  static const String authTokenKey = 'auth_token';
  
  AuthLocalDataSourceImpl();
  
  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final jsonString = await _secureStorage.read(key: cachedUserKey);
      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        return UserModel.fromJson(json);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached user: $e');
    }
  }
  
  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await _secureStorage.write(
        key: cachedUserKey, 
        value: jsonEncode(user.toJson())
      );
    } catch (e) {
      throw CacheException('Failed to cache user: $e');
    }
  }
  
  @override
  Future<void> clearUser() async {
    try {
      await _secureStorage.delete(key: cachedUserKey);
    } catch (e) {
      throw CacheException('Failed to clear user: $e');
    }
  }
  
  @override
  Future<String?> getAuthToken() async {
    try {
      return await _secureStorage.read(key: authTokenKey);
    } catch (e) {
      throw CacheException('Failed to get auth token: $e');
    }
  }
  
  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await _secureStorage.write(key: authTokenKey, value: token);
    } catch (e) {
      throw CacheException('Failed to save auth token: $e');
    }
  }
  
  @override
  Future<void> clearAuthToken() async {
    try {
      await _secureStorage.delete(key: authTokenKey);
    } catch (e) {
      throw CacheException('Failed to clear auth token: $e');
    }
  }
}