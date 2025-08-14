import '../../domain/entities/service.dart';

class ServiceModel extends Service {
  const ServiceModel({
    required super.code,
    required super.name,
    required super.iconUrl,
    required super.redirectTo,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      code: json['code'] as String,
      name: json['name'] as String,
      iconUrl: json['icon_url'] as String,
      redirectTo: json['redirect_to'] as String,
    );
  }

  factory ServiceModel.fromEntity(Service service) {
    return ServiceModel(
      code: service.code,
      name: service.name,
      iconUrl: service.iconUrl,
      redirectTo: service.redirectTo,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'icon_url': iconUrl,
      'redirect_to': redirectTo,
    };
  }
}