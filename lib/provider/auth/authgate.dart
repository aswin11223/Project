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
          // Check for the connection state of the stream
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for Firebase to initialize, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that occur during the connection
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            // User is signed in, navigate to the HomeScreen
            return HomeScreen();
          } else {
            // User is not signed in, navigate to the login or registration screen
            return loginorreg();
          }
        },
      ),
    );
  }
}
