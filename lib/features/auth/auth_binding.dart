import 'package:get/get.dart';
import 'data/auth_repository.dart';
import 'presentation/controllers/auth_controller.dart';
import 'presentation/controllers/onboarding_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository(Get.find(), Get.find()));
    Get.lazyPut(() => AuthController(Get.find()));
    Get.lazyPut(() => OnboardingController(Get.find()));
  }
}