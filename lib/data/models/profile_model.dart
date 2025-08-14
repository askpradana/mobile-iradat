import 'dart:convert';

class ProfileResponseModel {
  final bool success;
  final String? message;
  final ProfileModel data;
  final String timestamp;

  ProfileResponseModel({
    required this.success,
    this.message,
    required this.data,
    required this.timestamp,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      data: ProfileModel.fromJson(json['data']['user'] ?? {}),
      timestamp: json['timestamp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {'user': data.toJson()},
      'timestamp': timestamp,
    };
  }
}

class ProfileModel {
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
  final LastAnalyzedModel? lastAnalyzed;
  final String? verifiedAt;

  ProfileModel({
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

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
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
        ? LastAnalyzedModel.fromJson(_parseJsonString(json['last_analyzed']))
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

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> updateData = {};
    
    if (name.isNotEmpty) updateData['name'] = name;
    if (email != null && email!.isNotEmpty) updateData['email'] = email;
    if (phone != null && phone!.isNotEmpty) updateData['phone'] = phone;
    if (avatarPicture != null && avatarPicture!.isNotEmpty) updateData['avatar_picture'] = avatarPicture;
    if (dateOfBirth != null && dateOfBirth!.isNotEmpty) updateData['date_of_birth'] = dateOfBirth;
    
    return updateData;
  }

  ProfileModel copyWith({
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
    LastAnalyzedModel? lastAnalyzed,
    String? verifiedAt,
  }) {
    return ProfileModel(
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

  bool hasChangesFrom(ProfileModel original) {
    return name != original.name ||
           email != original.email ||
           phone != original.phone ||
           avatarPicture != original.avatarPicture ||
           dateOfBirth != original.dateOfBirth;
  }
}

class LastAnalyzedModel {
  final String comment;
  final String analyzedAt;
  final String lastAnalyzed;

  LastAnalyzedModel({
    required this.comment,
    required this.analyzedAt,
    required this.lastAnalyzed,
  });

  factory LastAnalyzedModel.fromJson(Map<String, dynamic> json) {
    return LastAnalyzedModel(
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

  String get displayTitle => lastAnalyzed.isNotEmpty ? lastAnalyzed : 'Analysis';
  
  int get score {
    // For now, return a placeholder score since it's not in the API
    // You might want to calculate this based on the analysis type
    return 75; // Default score
  }
  
  String get service => 'Psychological Analysis';
}

class ProfileUpdateModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? avatarPicture;
  final String? dateOfBirth;

  ProfileUpdateModel({
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

  bool get hasData {
    return toJson().isNotEmpty;
  }
}