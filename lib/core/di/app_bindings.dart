import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<FlutterSecureStorage>(
      const FlutterSecureStorage(),
      permanent: true,
    );

    Get.putAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance(),
      permanent: true,
    );

    Get.put<ApiClient>(
      ApiClient(Get.find<FlutterSecureStorage>()),
      permanent: true,
    );
  }
}