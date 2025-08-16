import 'package:get/get.dart';
import 'data/profile_repository.dart';
import 'presentation/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileRepository(Get.find(), Get.find()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}