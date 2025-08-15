import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';
import '../../settings/supabase.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> register(String email, String name, String password, String phone);
  Future<void> logout(String token);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  
  AuthRemoteDataSourceImpl(this.client);
  
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.supabaseUrl}/auth/v1/token?grant_type=password'),
        headers: {
          'Content-Type': 'application/json',
          'apikey': AppConstants.supabaseAPIKey,
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      
      final body = jsonDecode(response.body);
      
      if (response.statusCode == 200 && body['access_token'] != null) {
        return UserModel(
          id: body['user']?['id'] ?? '1',
          email: email,
          name: body['user']?['name'],
        );
      } else {
        throw ServerException(
          body['error_description'] ?? body['msg'] ?? 'Login failed',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error occurred: $e');
    }
  }
  
  @override
  Future<void> register(String email, String name, String password, String phone) async {
    try {
      final response = await client.post(
        Uri.parse('$backendBaseUrl/auth/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'name': name,
          'password': password,
          'phone': phone,
        }),
      );
      
      final body = jsonDecode(response.body);
      
      if (response.statusCode == 200 && body['success'] == true) {
        return;
      } else {
        throw ServerException(
          body['message'] ?? 'Registration failed',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error occurred: $e');
    }
  }
  
  @override
  Future<void> logout(String token) async {
    try {
      await client.post(
        Uri.parse('$backendBaseUrl/auth/logout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
    } catch (e) {
      // Ignore network errors - we'll clean storage regardless
    }
  }
}