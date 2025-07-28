import 'package:flutter/material.dart';
import 'package:quiz_iradat/screens/authorized/homepage/home_controller.dart';

class BottomNavigationBarHome extends StatelessWidget {
  const BottomNavigationBarHome({super.key, required this.c});

  final HomeController c;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        showSelectedLabels: true,
        currentIndex: c.currentIndex.value,
        onTap: (i) => c.currentIndex.value = i,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            activeIcon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
