import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/nav_provider.dart';
import 'package:flutter_application_8/view/componenets/botto_nav.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/category_text.dart';
import 'package:flutter_application_8/view/screeens/Cart_Screen.dart';
import 'package:flutter_application_8/view/screeens/Profile_page.dart';
import 'package:flutter_application_8/view/screeens/pages/Catogoery_Page.dart';
import 'package:flutter_application_8/view/screeens/pages/add_product.dart';
import 'package:flutter_application_8/view/screeens/discover_people.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final List<Widget> pages = [CategoryPage(), Discover(),CartScreen(),Profile(categoryId:FirebaseAuth.instance.currentUser!.uid ,)];

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade600,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductScreen()));
          // Your code for the FloatingActionButton press
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNav(
        onTap: navProvider.setIndex,
        currentIndex: navProvider.selectedIndex,
      ),
      body: pages[navProvider.selectedIndex],
    );
  }
}
