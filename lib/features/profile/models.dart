import 'package:equatable/equatable.dart';
import 'dart:convert';

class Profile extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final int roleId;
  final String? roleName;
  final String? profileId;
  final String? avatarPicture;
  final String? dateOfBirth;
  final String? organizationId;
  final Map<String, dynamic> ipro;
  final Map<String, dynamic> iprob;
  final Map<String, dynamic> ipros;
  final LastAnalyzed? lastAnalyzed;
  final String? verifiedAt;

  const Profile({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    required this.roleId,
    this.roleName,
    this.profileId,
    this.avatarPicture,
    this.dateOfBirth,
    this.organizationId,
    required this.ipro,
    required this.iprob,
    required this.ipros,
    this.lastAnalyzed,
    this.verifiedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'],
      phone: json['phone'],
      roleId: json['role_id'] ?? 0,
      roleName: json['role_name'],
      profileId: json['profile_id'],
      avatarPicture: json['avatar_picture'],
      dateOfBirth: json['date_of_birth'],
      organizationId: json['organization_id'],
      ipro: _parseJsonString(json['ipro'] ?? '{}'),
      iprob: _parseJsonString(json['iprob'] ?? '{}'),
      ipros: _parseJsonString(json['ipros'] ?? '{}'),
      lastAnalyzed: json['last_analyzed'] != null 
        ? LastAnalyzed.fromJson(_parseJsonString(json['last_analyzed']))
        : null,
      verifiedAt: json['verified_at'],
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
      'name': name,
      'email': email,
      'phone': phone,
      'role_id': roleId,
      'role_name': roleName,
      'profile_id': profileId,
      'avatar_picture': avatarPicture,
      'date_of_birth': dateOfBirth,
      'organization_id': organizationId,
      'ipro': jsonEncode(ipro),
      'iprob': jsonEncode(iprob),
      'ipros': jsonEncode(ipros),
      'last_analyzed': lastAnalyzed != null ? jsonEncode(lastAnalyzed!.toJson()) : null,
      'verified_at': verifiedAt,
    };
  }

  Profile copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    int? roleId,
    String? roleName,
    String? profileId,
    String? avatarPicture,
    String? dateOfBirth,
    String? organizationId,
    Map<String, dynamic>? ipro,
    Map<String, dynamic>? iprob,
    Map<String, dynamic>? ipros,
    LastAnalyzed? lastAnalyzed,
    String? verifiedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
      profileId: profileId ?? this.profileId,
      avatarPicture: avatarPicture ?? this.avatarPicture,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      organizationId: organizationId ?? this.organizationId,
      ipro: ipro ?? this.ipro,
      iprob: iprob ?? this.iprob,
      ipros: ipros ?? this.ipros,
      lastAnalyzed: lastAnalyzed ?? this.lastAnalyzed,
      verifiedAt: verifiedAt ?? this.verifiedAt,
    );
  }

  @override
  List<Object?> get props => [
    id, name, email, phone, roleId, roleName, profileId,
    avatarPicture, dateOfBirth, organizationId, ipro, iprob, ipros,
    lastAnalyzed, verifiedAt
  ];
}

class LastAnalyzed extends Equatable {
  final String comment;
  final String analyzedAt;
  final String lastAnalyzed;

  const LastAnalyzed({
    required this.comment,
    required this.analyzedAt,
    required this.lastAnalyzed,
  });

  factory LastAnalyzed.fromJson(Map<String, dynamic> json) {
    return LastAnalyzed(
      comment: json['comment'] ?? '',
      analyzedAt: json['analyzed_at'] ?? '',
      lastAnalyzed: json['last_analyzed'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'analyzed_at': analyzedAt,
      'last_analyzed': lastAnalyzed,
    };
  }

  DateTime? get parsedDate {
    try {
      return DateTime.parse(analyzedAt);
    } catch (e) {
      return null;
    }
  }

  String get formattedDate {
    final parsed = parsedDate;
    if (parsed != null) {
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    }
    return analyzedAt;
  }

  @override
  List<Object?> get props => [comment, analyzedAt, lastAnalyzed];
}

class ProfileUpdate extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? avatarPicture;
  final String? dateOfBirth;

  const ProfileUpdate({
    this.name,
    this.email,
    this.phone,
    this.avatarPicture,
    this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    
    if (name != null && name!.isNotEmpty) data['name'] = name;
    if (email != null && email!.isNotEmpty) data['email'] = email;
    if (phone != null && phone!.isNotEmpty) data['phone'] = phone;
    if (avatarPicture != null && avatarPicture!.isNotEmpty) data['avatar_picture'] = avatarPicture;
    if (dateOfBirth != null && dateOfBirth!.isNotEmpty) data['date_of_birth'] = dateOfBirth;
    
    return data;
  }

  bool get hasData => toJson().isNotEmpty;

  @override
  List<Object?> get props => [name, email, phone, avatarPicture, dateOfBirth];
}