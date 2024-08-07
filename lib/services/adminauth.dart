import 'package:firebase_auth/firebase_auth.dart';

class AdminAuth {
  final FirebaseAuth _adminAuth = FirebaseAuth.instance;

  // Define the permanent admin credentials
  final String _adminEmail = "ramu@gmail.com"; // Replace with your admin email
  final String _adminPassword = "1234567890"; // Replace with your admin password

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Check if the provided credentials match the admin credentials
      if (email == _adminEmail && password == _adminPassword) {
        UserCredential userCredential = await _adminAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } else {
        throw FirebaseAuthException(
          code: 'invalid-admin-credentials',
          message: 'Invalid admin credentials',
        );
      }
    } on FirebaseAuthException catch (e) {
      throw Exception('Error: ${e.message}');
    }
  }

  Future<void> logout() async {
    await _adminAuth.signOut();
  }
   

}
