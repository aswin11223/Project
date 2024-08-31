import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/loginor_reg.dart';
import 'package:flutter_application_8/view/screeens/Home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading indicator while waiting for data
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            // User is authenticated, navigate to HomeScreen
            return  HomeScreen
            ();
          } else if (snapshot.hasError) {
            // Handle any errors from the auth stream
            return Center(
              child: Text('Something went wrong: ${snapshot.error}'),
            );
          } else {
            // User is not authenticated, navigate to login or registration screen
            return  loginorreg();
          }
        },
      ),
    );
  }
}
