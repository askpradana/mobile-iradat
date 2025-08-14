import 'base_entity.dart';

class Service extends BaseEntity {
  final String code;
  final String name;
  final String iconUrl;
  final String redirectTo;
  
  const Service({
    required this.code,
    required this.name,
    required this.iconUrl,
    required this.redirectTo,
  });
  
  @override
  List<Object?> get props => [code, name, iconUrl, redirectTo];
}