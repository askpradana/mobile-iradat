import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_iradat/screens/authorized/homepage/components/bottomnavbar.dart';
import 'package:quiz_iradat/screens/authorized/homepage/components/home_components.dart';
import 'package:quiz_iradat/screens/authorized/homepage/components/settings_components.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(title: Text(c.bottomNavbarTitles[c.currentIndex.value])),
        body: IndexedStack(
          index: c.currentIndex.value,
          children: [
            HomeComponents(controller: c),
            SettingsComponents(controller: c),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarHome(c: c),
      ),
    );
  }
}
