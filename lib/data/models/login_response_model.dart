import 'user_model.dart';
import 'service_model.dart';

class LoginResponseModel {
  final bool success;
  final String message;
  final LoginDataModel data;
  final String timestamp;

  const LoginResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: LoginDataModel.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': data.toJson(),
      'timestamp': timestamp,
    };
  }
}

class LoginDataModel {
  final String token;
  final UserModel user;
  final List<ServiceModel> services;

  const LoginDataModel({
    required this.token,
    required this.user,
    required this.services,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>)
          .map((service) => ServiceModel.fromJson(service as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}