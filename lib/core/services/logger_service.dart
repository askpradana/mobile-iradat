import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

class LoggerService {
  static const String _appName = 'QuizIradat';
  
  static void log(String message, {LogLevel level = LogLevel.info}) {
    if (!kDebugMode) return;
    
    final timestamp = DateTime.now().toIso8601String();
    final levelIcon = _getLevelIcon(level);
    final formattedMessage = '[$_appName] $timestamp $levelIcon $message';
    
    debugPrint(formattedMessage);
  }
  
  static void debug(String message) {
    log(message, level: LogLevel.debug);
  }
  
  static void info(String message) {
    log(message, level: LogLevel.info);
  }
  
  static void success(String message) {
    log('✅ $message', level: LogLevel.info);
  }
  
  static void warning(String message) {
    log(message, level: LogLevel.warning);
  }
  
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    log(message, level: LogLevel.error);
    if (error != null) log('Error details: $error', level: LogLevel.error);
    if (stackTrace != null) log('Stack trace: $stackTrace', level: LogLevel.error);
  }
  
  static String _getLevelIcon(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '🔍';
      case LogLevel.info:
        return 'ℹ️';
      case LogLevel.warning:
        return '⚠️';
      case LogLevel.error:
        return '🔴';
    }
  }
}