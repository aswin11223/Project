import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGoogle {
  // Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign in with Google
     signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if (gUser == null) {
        // If the user cancels the sign-in process, return null
        return null;
      }

      // Obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final  credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
     

      // Return the signed-in user
       return await FirebaseAuth.instance.signInWithCredential(credential);
      
    }catch(e){
      print(e);
    }
     
}
}
