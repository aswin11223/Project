import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/intro_page.dart';
import 'package:flutter_application_8/firebase_options.dart';
import 'package:flutter_application_8/services/notifiaction_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);
     
    
    print("Firebase initialized successfully");
  } catch (e) {
    Text(e.toString());
    print(e.toString());
  }


  runApp(
    const IntroPage(),
  );
} 

