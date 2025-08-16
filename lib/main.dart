import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/app_routes.dart';
import 'package:quiz_iradat/core/di/app_bindings.dart';
import 'package:quiz_iradat/core/theme/app_theme.dart';
import 'package:quiz_iradat/core/theme/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      init: ThemeController(),
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialBinding: AppBindings(),
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          title: 'Quiz Iradat',
          
          // Theme configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.themeMode,
          
          // Remove splash screen when app is ready
          home: null,
        );
      },
    );
  }
}
