import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ModalDialog provides reusable modal dialogs for confirmation and loading states.
///
/// Usage:
///   await ModalDialog.showLogoutConfirmation();
///   ModalDialog.showLoadingDialog();
class ModalDialog {
  /// Shows a confirmation dialog for logout.
  ///
  /// Returns true if the user confirms, false otherwise.
  static Future<bool?> showLogoutConfirmation() {
    return Get.dialog<bool>(
      TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: AlertDialog(
              backgroundColor: Colors.grey[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: Row(
                children: [
                  Icon(Icons.logout_rounded, color: Colors.red[600], size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Logout Confirmation',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              content: const Text(
                'Are you sure you want to logout? You will need to sign in again to access your account.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    foregroundColor: Colors.grey[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      barrierDismissible: false,
    );
  }

  /// Shows a loading dialog with animation and disables pop.
  ///
  /// Call Get.back() to dismiss.
  static void showLoadingDialog({
    String title = 'Logging out...',
    String message = 'Please wait while we securely log you out',
  }) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          backgroundColor: Colors.grey[50],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * 2 * 3.14159,
                      child: Icon(
                        Icons.logout_rounded,
                        size: 48,
                        color: Colors.red[600],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const LinearProgressIndicator(
                  color: Colors.green,
                  backgroundColor: Colors.greenAccent,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
