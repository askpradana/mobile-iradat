import '../entities/base_entity.dart';

class User extends BaseEntity {
  final String id;
  final String email;
  final String? name;
  final int? roleId;
  final DateTime? createdAt;
  
  const User({
    required this.id,
    required this.email,
    this.name,
    this.roleId,
    this.createdAt,
  });
  
  @override
  List<Object?> get props => [id, email, name, roleId, createdAt];
}