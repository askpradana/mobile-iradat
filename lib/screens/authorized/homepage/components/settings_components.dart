import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_controller.dart';
import 'package:quiz_iradat/settings/route_management.dart';

class SettingsComponents extends StatelessWidget {
  const SettingsComponents({super.key, required this.controller});

  final HomeController controller;

  // Preserved when menu have disabled or maintenance mode
  // void _snack(BuildContext context, String message) {
  //   ScaffoldMessenger.of(
  //     context,
  //   ).showSnackBar(SnackBar(content: Text(message)));
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person_outline),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.editProfile),
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode_outlined),
          title: const Text('Dark Mode'),
          trailing: Obx(() {
            final isDark = controller.themeMode.value == ThemeMode.dark;
            return Switch(
              value: isDark,
              onChanged: (value) {
                controller.toggleTheme(value ? 1 : 0);
              },
              activeColor: Colors.purple,
            );
          }),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About Application'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.aboutApplication),
        ),
        ListTile(
          leading: const Icon(Icons.help_outline),
          title: const Text('Frequently Asked Questions'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.faq),
        ),
        ListTile(
          leading: const Icon(Icons.contact_mail_outlined),
          title: const Text('Contact Us'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.contactUs),
        ),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Privacy Policy'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
        ),
        const Divider(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => controller.handleLogout(),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 1000),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.9 + (0.1 * value),
                          child: Icon(
                            Icons.logout_rounded,
                            color: Colors.red[600],
                            size: 24,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 32),
                    Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red[600],
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
