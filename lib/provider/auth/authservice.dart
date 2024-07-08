import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authservice{
  //get instance of firebase

  final FirebaseAuth _auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;


  User?getcurrentuser(){
     return   _auth.currentUser;
  }

  //signin

  Future<UserCredential>signinwithemailpassword(String email,password)async{
    try{
      UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);

   //save user info if it dosen't already exist





      return userCredential;
    }on FirebaseAuthException catch(e){
      throw Exception(e.code);
      
    }

  }
  //signout

  Future<void>signout()async{
      return await  _auth.signOut();


  }
  //signup

  Future<UserCredential>signupwithemailandpassowrd(String email,password)async{
   try{
     UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);

//save user info in a seperate document




    return userCredential;
   }on FirebaseAuthException catch(e){
    throw Exception(e.code);
   }


  }

  signinwithgoogle()async{
    final GoogleSignInAccount? guser=await GoogleSignIn().signIn();


    final GoogleSignInAuthentication? gauth=await guser!.authentication;


    final credential=GoogleAuthProvider.credential(
      accessToken: gauth!.accessToken,
      idToken: gauth.idToken

    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
    
      }
   
  
}