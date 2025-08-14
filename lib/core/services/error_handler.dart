import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../errors/failures.dart';
import '../errors/exceptions.dart';

class ErrorHandler {
  static Failure handleException(Exception exception) {
    if (kDebugMode) {
      debugPrint('Exception caught: $exception');
    }
    
    switch (exception.runtimeType) {
      case ServerException:
        return ServerFailure((exception as ServerException).message);
      case CacheException:
        return CacheFailure((exception as CacheException).message);
      case NetworkException:
        return NetworkFailure((exception as NetworkException).message);
      default:
        return ServerFailure('Unexpected error occurred');
    }
  }
  
  static void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  static void logError(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('🔴 ERROR: $message');
      if (error != null) debugPrint('Error details: $error');
      if (stackTrace != null) debugPrint('Stack trace: $stackTrace');
    }
  }
  
  static void logInfo(String message) {
    if (kDebugMode) {
      debugPrint('ℹ️ INFO: $message');
    }
  }
  
  static void logSuccess(String message) {
    if (kDebugMode) {
      debugPrint('✅ SUCCESS: $message');
    }
  }
}