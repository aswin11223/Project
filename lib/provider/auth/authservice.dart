import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_8/model/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await saveUserDetails(userCredential.user!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Error signing in');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password, String displayName, File imageFile) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      final ref = FirebaseStorage.instance.ref().child('profile_images').child('${userCredential.user!.uid}.jpg');
      await ref.putFile(imageFile);
      final photoURL = await ref.getDownloadURL();

      await userCredential.user!.updateDisplayName(displayName);
      await userCredential.user!.updatePhotoURL(photoURL);
      await saveUserDetails(userCredential.user!);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Error signing up');
    }
  }

  Future<void> saveUserDetails(User user) async {
    UserModel userModel = UserModel(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName ?? '',
      photoURL: user.photoURL ?? '',
    );

    DocumentReference userRef = _firestore.collection('userss').doc(user.uid);
    DocumentSnapshot doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set(userModel.toMap());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) {
      throw Exception('Google sign-in aborted');
    }
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    UserCredential userCredential = await _auth.signInWithCredential(credential);
    await saveUserDetails(userCredential.user!);

    return userCredential;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Error sending password reset email');
    }
  }

  Future<UserModel?> fetchUserDetails() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('userss').doc(user.uid).get();
      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data()!);
      }
    }
    return null;
  }
  Future<void> deleteUserAccount(String uid) async {
  try {
    // Reference to the user document in Firestore
    DocumentReference userRef = _firestore.collection('userss').doc(uid);
    DocumentSnapshot userDoc = await userRef.get();
    
    if (!userDoc.exists) {
      throw Exception('User document not found in Firestore');
    }

    // Delete user data from Firestore
    await userRef.delete();

    // Delete user profile image from Firebase Storage
    final ref = FirebaseStorage.instance.ref().child('profile_images').child('$uid.jpg');
    
    try {
      await ref.delete();
    } catch (e) {
      print('Profile image not found or could not be deleted: $e');
      // Optionally, continue or throw an exception if profile image deletion is critical
    }

    // Delete user account from Firebase Authentication
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      // Check if the current user is the one being deleted
      if (currentUser.uid == uid) {
        await currentUser.delete();
      } else {
        throw Exception('The account to be deleted does not match the currently signed-in user');
      }
    } else {
      throw Exception('No user is currently signed in');
    }
  } on FirebaseAuthException catch (e) {
    throw Exception('FirebaseAuthException: ${e.message}');
  } catch (e) {
    throw Exception('Error deleting user account: $e');
  }
}


}