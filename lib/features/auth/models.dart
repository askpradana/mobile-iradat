import 'package:equatable/equatable.dart';
import 'dart:convert';

class LoginResponse extends Equatable {
  final bool success;
  final String message;
  final LoginData data;
  final String timestamp;

  const LoginResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );
  }

  @override
  List<Object?> get props => [success, message, data, timestamp];
}

class LoginData extends Equatable {
  final String token;
  final String expiresAt;
  final User user;
  final List<Service> services;

  const LoginData({
    required this.token,
    required this.expiresAt,
    required this.user,
    required this.services,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      token: json['token'] as String,
      expiresAt: json['expires_at'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>)
          .map((service) => Service.fromJson(service as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [token, expiresAt, user, services];
}

class User extends Equatable {
  final String id;
  final String email;
  final String phone;
  final int roleId;
  final String roleName;
  final String profileId;
  final String name;
  final String? avatarPicture;
  final String? dateOfBirth;
  final String? organizationId;
  final Map<String, dynamic> ipro;
  final Map<String, dynamic> iprob;
  final Map<String, dynamic> ipros;
  final Map<String, dynamic> lastAnalyzed;
  final String verifiedAt;

  const User({
    required this.id,
    required this.email,
    required this.phone,
    required this.roleId,
    required this.roleName,
    required this.profileId,
    required this.name,
    this.avatarPicture,
    this.dateOfBirth,
    this.organizationId,
    required this.ipro,
    required this.iprob,
    required this.ipros,
    required this.lastAnalyzed,
    required this.verifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      roleId: json['role_id'] as int,
      roleName: json['role_name'] as String,
      profileId: json['profile_id'] as String,
      name: json['name'] as String,
      avatarPicture: json['avatar_picture'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      organizationId: json['organization_id'] as String?,
      ipro: _parseJsonString(json['ipro'] as String? ?? '{}'),
      iprob: _parseJsonString(json['iprob'] as String? ?? '{}'),
      ipros: _parseJsonString(json['ipros'] as String? ?? '{}'),
      lastAnalyzed: _parseJsonString(json['last_analyzed'] as String? ?? '{}'),
      verifiedAt: json['verified_at'] as String,
    );
  }

  static Map<String, dynamic> _parseJsonString(String jsonStr) {
    try {
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'role_id': roleId,
      'role_name': roleName,
      'profile_id': profileId,
      'name': name,
      'avatar_picture': avatarPicture,
      'date_of_birth': dateOfBirth,
      'organization_id': organizationId,
      'ipro': jsonEncode(ipro),
      'iprob': jsonEncode(iprob),
      'ipros': jsonEncode(ipros),
      'last_analyzed': jsonEncode(lastAnalyzed),
      'verified_at': verifiedAt,
    };
  }

  @override
  List<Object?> get props => [
    id, email, phone, roleId, roleName, profileId, name,
    avatarPicture, dateOfBirth, organizationId, ipro, iprob, ipros,
    lastAnalyzed, verifiedAt
  ];
}

class Service extends Equatable {
  final String code;
  final String name;
  final String iconUrl;
  final String redirectTo;
  final String createdAt;
  final String updatedAt;

  const Service({
    required this.code,
    required this.name,
    required this.iconUrl,
    required this.redirectTo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      code: json['code'] as String,
      name: json['name'] as String,
      iconUrl: json['icon_url'] as String,
      redirectTo: json['redirect_to'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );
  }

  @override
  List<Object?> get props => [code, name, iconUrl, redirectTo, createdAt, updatedAt];
}

class RegisterResponse extends Equatable {
  final bool success;
  final String message;
  final String timestamp;

  const RegisterResponse({
    required this.success,
    required this.message,
    required this.timestamp,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  @override
  List<Object?> get props => [success, message, timestamp];
}

class OnboardingItem extends Equatable {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [title, description, imagePath];
}