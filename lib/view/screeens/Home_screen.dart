import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/nav_provider.dart';
import 'package:flutter_application_8/view/componenets/botto_nav.dart';
import 'package:flutter_application_8/view/screeens/Cart_Screen.dart';
import 'package:flutter_application_8/view/screeens/Profile_page.dart';
import 'package:flutter_application_8/view/screeens/pages/Catogoery_Page.dart';
import 'package:flutter_application_8/view/screeens/pages/notification_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // Get the current user once and store it for reuse
    final currentUser = auth.currentUser;
    final navProvider = Provider.of<NavProvider>(context);

    // Safety checks for user details
    final String userName = currentUser?.displayName ?? 'No Name';
    // final String email = currentUser?.email ?? 'No Email';
    // final String imageUrl = currentUser?.photoURL ??"";

    // List of pages for the bottom navigation
    final List<Widget> pages = [
      const CategoryPage(),
      CartScreen(),
      ProfilePage(
       
  
         // Can be null; handle this in ProfilePage widget
      ),
      NotificationsPage(
        userId: currentUser!.uid, // Assumes uid is always non-null
      ),
      
    ];
    print(userName);

    return Scaffold(
      bottomNavigationBar: BottomNav(
        onTap: navProvider.setIndex,
        currentIndex: navProvider.selectedIndex,
      ),
      body: pages[navProvider.selectedIndex],
    );
  }
}
