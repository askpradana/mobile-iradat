import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../settings/supabase.dart';
import '../../core/services/auth_storage_service.dart';
import '../models/profile_model.dart';

class ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSource({http.Client? client})
    : client = client ?? http.Client();

  Future<ProfileResponseModel> getProfile() async {
    try {
      final token = await AuthStorageService.getAuthToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await client.get(
        Uri.parse('$backendBaseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ProfileResponseModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to fetch profile data');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException')) {
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      }
      rethrow;
    }
  }

  Future<ProfileResponseModel> updateProfile(
    ProfileUpdateModel updateData,
  ) async {
    try {
      if (!updateData.hasData) {
        throw Exception('At least one field must be provided for update');
      }

      final token = await AuthStorageService.getAuthToken();
      if (token == null) {
        throw Exception('No authentication token found');
      }

      final response = await client.put(
        Uri.parse('$backendBaseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(updateData.toJson()),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return ProfileResponseModel.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw Exception('Authentication failed. Please login again.');
      } else if (response.statusCode == 400) {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Invalid update data provided');
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['message'] ?? 'Failed to update profile');
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('TimeoutException')) {
        throw Exception(
          'Network error. Please check your internet connection.',
        );
      }
      rethrow;
    }
  }
}
