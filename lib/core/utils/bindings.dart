import 'package:get/get.dart';
import '../../features/auth/presentation/controllers/login_controller.dart';
import '../../features/auth/presentation/controllers/register_controller.dart';
import '../../features/auth/presentation/controllers/onboarding_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize core services that should be available globally
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(loginUseCase: Get.find()),
    );
    
    Get.lazyPut<RegisterController>(
      () => RegisterController(registerUseCase: Get.find()),
    );
    
    Get.lazyPut<OnboardingController>(
      () => OnboardingController(getAuthStatusUseCase: Get.find()),
    );
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Home-related controllers will be registered here  
  }
}

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    // Quiz-related controllers will be registered here
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    // Settings-related controllers will be registered here
  }
}