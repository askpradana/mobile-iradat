import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/network/api_client.dart';
import '../../../core/utils/notification_service.dart';
import '../models.dart';

class AnonymousRepository {
  final ApiClient api;
  final FlutterSecureStorage secureStorage;

  AnonymousRepository(this.api, this.secureStorage);

  Future<ReferralValidationResponse?> validateReferralCode(String code) async {
    try {
      final response = await api.get('/quiz/anonymous/validate/$code');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final validationResponse = ReferralValidationResponse.fromJson(jsonData);
        
        if (validationResponse.success) {
          return validationResponse;
        } else {
          NotificationService.showError('Invalid Code', validationResponse.message);
          return null;
        }
      } else {
        final errorData = jsonDecode(response.body);
        NotificationService.showError(
          'Validation Failed', 
          errorData['message'] ?? 'Invalid referral code'
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

  Future<AnonymousRegistrationResponse?> registerAnonymous(
    String referralCode, 
    AnonymousRegistrationRequest request
  ) async {
    try {
      final response = await api.post(
        '/quiz/anonymous/$referralCode/register', 
        request.toJson()
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final registrationResponse = AnonymousRegistrationResponse.fromJson(jsonData);
        
        if (registrationResponse.success) {
          // Store anonymous token and data
          await secureStorage.write(
            key: 'anonymousToken',
            value: registrationResponse.data.token,
          );
          await secureStorage.write(
            key: 'anonymousExpiresAt',
            value: registrationResponse.data.expiresAt,
          );
          await secureStorage.write(
            key: 'anonymousId',
            value: registrationResponse.data.anonymousId,
          );
          
          NotificationService.showSuccess('Welcome!', 'Quiz access granted successfully');
          return registrationResponse;
        } else {
          NotificationService.showError('Registration Failed', registrationResponse.message);
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

  Future<QuizSubmissionResponse?> submitQuiz(QuizSubmissionRequest request) async {
    try {
      final response = await api.post('/quiz/submit', request.toJson());

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        try {
          final submissionResponse = QuizSubmissionResponse.fromJson(jsonData);
          
          if (submissionResponse.success) {
            // Clear anonymous token after successful submission
            await _clearAnonymousData();
            
            NotificationService.showSuccess(
              'Quiz Completed!', 
              submissionResponse.message
            );
            return submissionResponse;
          } else {
            NotificationService.showError('Submission Failed', submissionResponse.message);
            return null;
          }
        } catch (parseError) {
          // JSON parsing error - this helps distinguish from network errors
          print('ERROR: Quiz submission JSON parsing failed: $parseError');
          print('Response body: ${response.body}');
          NotificationService.showError(
            'Data Processing Error', 
            'Failed to process quiz results. Please try again.'
          );
          return null;
        }
      } else {
        final errorData = jsonDecode(response.body);
        NotificationService.showError(
          'Submission Failed', 
          errorData['message'] ?? 'Failed to submit quiz. Please try again.'
        );
        return null;
      }
    } catch (e) {
      // Network or other connectivity errors
      print('ERROR: Quiz submission network error: $e');
      NotificationService.showError(
        'Network Error', 
        'Please check your internet connection and try again'
      );
      return null;
    }
  }

  Future<bool> isAnonymousLoggedIn() async {
    try {
      final token = await secureStorage.read(key: 'anonymousToken');
      final expiresAt = await secureStorage.read(key: 'anonymousExpiresAt');
      
      if (token != null && expiresAt != null) {
        final expiry = DateTime.parse(expiresAt);
        return DateTime.now().isBefore(expiry);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getAnonymousToken() async {
    try {
      return await secureStorage.read(key: 'anonymousToken');
    } catch (e) {
      return null;
    }
  }

  Future<String?> getAnonymousId() async {
    try {
      return await secureStorage.read(key: 'anonymousId');
    } catch (e) {
      return null;
    }
  }

  Future<void> _clearAnonymousData() async {
    try {
      await secureStorage.delete(key: 'anonymousToken');
      await secureStorage.delete(key: 'anonymousExpiresAt');
      await secureStorage.delete(key: 'anonymousId');
    } catch (e) {
      // Silently handle errors for cleanup
    }
  }

  Future<void> clearAnonymousSession() async {
    await _clearAnonymousData();
    NotificationService.showInfo('Session Cleared', 'Anonymous session has been cleared');
  }
}