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
        showSelectedLabels: false,
        currentIndex: c.currentIndex.value,
        onTap: (i) => c.currentIndex.value = i,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
