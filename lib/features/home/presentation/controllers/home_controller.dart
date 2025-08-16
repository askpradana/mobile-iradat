import 'package:get/get.dart';
import 'package:quiz_iradat/core/utils/notification_service.dart';
import '../../../auth/data/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository authRepo;

  HomeController(this.authRepo);

  final currentIndex = 0.obs;

  final bottomNavbarTitles = ['Home', 'Settings'];

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  Future<void> logout() async {
    final success = await authRepo.logout();
    if (success) {
      Get.offAllNamed('/onboarding');
    }
  }

  void navigateToProfile() {
    Get.toNamed('/profile');
  }

  void navigateToQuizzes() {
    // Will be implemented when quiz feature is migrated
    NotificationService.showInfo(
      'Coming Soon',
      'Quiz feature will be available soon',
    );
  }
}
