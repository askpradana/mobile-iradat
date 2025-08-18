import 'package:get/get.dart';
import 'data/anonymous_repository.dart';
import 'presentation/controllers/anonymous_quiz_controller.dart';

class AnonymousBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnonymousRepository(Get.find(), Get.find()));
    Get.lazyPut(() => AnonymousQuizController(Get.find()));
  }
}