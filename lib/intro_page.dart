import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/add_productprovider.dart';

import 'package:flutter_application_8/provider/auth/authgate.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/provider/loginor_regprovider.dart';

import 'package:flutter_application_8/provider/nav_provider.dart';
import 'package:flutter_application_8/view/theme/light_mode.dart';
import 'package:provider/provider.dart'; // Ensure the correct import path

class Intro_page extends StatelessWidget {
  const Intro_page({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavProvider(),
        ),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => AddProductProvider()),
         ChangeNotifierProvider(create: (context) =>Logorreg()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightmode,
        home: AuthGate(),
      ),
    );
  }
}
