import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/add_productprovider.dart';
import 'package:flutter_application_8/provider/addprovider.dart';
import 'package:flutter_application_8/provider/auth/authgate.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/provider/locationprovider.dart';
import 'package:flutter_application_8/provider/loginor_regprovider.dart';
import 'package:flutter_application_8/provider/nav_provider.dart';
import 'package:flutter_application_8/provider/order_provider.dart';
import 'package:flutter_application_8/provider/profileprovider/like_provider.dart';
import 'package:flutter_application_8/provider/profileprovider/profileprovider.dart';
import 'package:flutter_application_8/provider/themeprovider/themeprovider.dart';
import 'package:provider/provider.dart'; // Ensure the correct import path

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => AddProductProvider()),
        ChangeNotifierProvider(create: (_) => Logorreg()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => Profileprovider()),
        ChangeNotifierProvider(create: (_) => Like()),
        ChangeNotifierProvider(create: (_) => Addprovider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => Themeprovider()),
         ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: Consumer<Themeprovider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themedata,
            home: AuthGate(),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(IntroPage());
}
