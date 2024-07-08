import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNav extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;

  BottomNav({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const [
        Icon(Icons.home, color: Colors.brown),
        Icon(Icons.favorite, color: Colors.brown,),
        Icon(Icons.shop, color: Colors.brown),
        Icon(Icons.person, color: Colors.brown),
      ],
      backgroundColor: Colors.brown.shade400,
      color: Colors.white,
      buttonBackgroundColor: Colors.brown.shade100,
      height: 60,
      index: currentIndex,
      onTap: onTap,
    );
  }
}
