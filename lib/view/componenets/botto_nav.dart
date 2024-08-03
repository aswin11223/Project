import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;

  BottomNav({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.brown),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop, color: Colors.brown),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.brown),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.brown.shade700,
      unselectedItemColor: Colors.brown.shade300,
      onTap: onTap,
    );
  }
}
