import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/errors/exceptions.dart';
import '../../core/constants/app_constants.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
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
  Future<void> logout(String token) async {
    try {
      final response = await client.post(
        Uri.parse('${AppConstants.supabaseUrl}/auth/v1/logout'),
        headers: {
          'Content-Type': 'application/json',
          'apikey': AppConstants.supabaseAPIKey,
          'Authorization': 'Bearer $token',
        },
      );
      
      if (response.statusCode != 200) {
        throw ServerException('Logout failed');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error occurred during logout: $e');
    }
  }
}