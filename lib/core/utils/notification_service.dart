import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService {
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green[600],
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.white,
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      boxShadows: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.3),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
      overlayBlur: 0.5,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      icon: const Icon(
        Icons.error_outline_rounded,
        color: Colors.white,
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      boxShadows: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.3),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
      overlayBlur: 0.5,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }

  static void showInfo(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.blue[600],
      colorText: Colors.white,
      icon: const Icon(
        Icons.info_outline_rounded,
        color: Colors.white,
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      boxShadows: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.3),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
      overlayBlur: 0.5,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }

  static void showWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.orange[600],
      colorText: Colors.white,
      icon: const Icon(
        Icons.warning_amber_outlined,
        color: Colors.white,
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      boxShadows: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.3),
          spreadRadius: 1,
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
      overlayBlur: 0.5,
      overlayColor: Colors.black.withValues(alpha: 0.1),
    );
  }
}