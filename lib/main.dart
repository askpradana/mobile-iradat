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
  
  // Pre-initialize ThemeController before building any widgets
  try {
    Get.put(ThemeController(), permanent: true);
  } catch (e) {
    debugPrint('Error initializing ThemeController: $e');
    // Continue with app startup even if theme initialization fails
  }
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ThemeController>(
      builder: (themeController) {
        // Show loading screen until theme is initialized
        if (!themeController.isInitialized) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.quiz,
                      size: 80,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Quiz Iradat',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 48),
                    CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

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
