import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/errors/failures.dart';

abstract class BaseController extends GetxController {
  final isLoading = false.obs;
  final error = Rxn<String>();
  
  void setLoading(bool loading) {
    isLoading.value = loading;
  }
  
  void setError(String? errorMessage) {
    error.value = errorMessage;
  }
  
  void clearError() {
    error.value = null;
  }
  
  void handleFailure(Failure failure) {
    setError(failure.message);
    debugPrint('Controller Error: ${failure.message}');
  }
  
  void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }
  
  void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }
}