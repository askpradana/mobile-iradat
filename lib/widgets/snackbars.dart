import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static SnackbarController showError(String message, String detail) {
    return Get.snackbar(
      message,
      detail,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      icon: Icon(Icons.error_outline_rounded, color: Colors.white, size: 28),
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
      titleText: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        detail,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }

  static SnackbarController showSuccess(String message, String detail) {
    return Get.snackbar(
      message,
      detail,
      backgroundColor: Colors.green[600],
      colorText: Colors.white,
      icon: Icon(
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
      titleText: Text(
        message,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        detail,
        style: TextStyle(
          fontSize: 14,
          color: Colors.white.withValues(alpha: 0.9),
        ),
      ),
    );
  }
}
