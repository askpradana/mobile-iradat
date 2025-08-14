import 'package:shared_preferences/shared_preferences.dart';
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
  final SharedPreferences sharedPreferences;
  
  static const String cachedUserKey = 'CACHED_USER';
  static const String authTokenKey = 'auth_token';
  
  AuthLocalDataSourceImpl(this.sharedPreferences);
  
  @override
  Future<UserModel?> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(cachedUserKey);
      if (jsonString != null) {
        return UserModel.fromJson({'email': jsonString, 'id': '1'});
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached user: $e');
    }
  }
  
  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await sharedPreferences.setString(cachedUserKey, user.email);
    } catch (e) {
      throw CacheException('Failed to cache user: $e');
    }
  }
  
  @override
  Future<void> clearUser() async {
    try {
      await sharedPreferences.remove(cachedUserKey);
    } catch (e) {
      throw CacheException('Failed to clear user: $e');
    }
  }
  
  @override
  Future<String?> getAuthToken() async {
    try {
      return sharedPreferences.getString(authTokenKey);
    } catch (e) {
      throw CacheException('Failed to get auth token: $e');
    }
  }
  
  @override
  Future<void> saveAuthToken(String token) async {
    try {
      await sharedPreferences.setString(authTokenKey, token);
    } catch (e) {
      throw CacheException('Failed to save auth token: $e');
    }
  }
  
  @override
  Future<void> clearAuthToken() async {
    try {
      await sharedPreferences.remove(authTokenKey);
    } catch (e) {
      throw CacheException('Failed to clear auth token: $e');
    }
  }
}