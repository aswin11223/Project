import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/authgate.dart';
import 'package:flutter_application_8/view/screeens/Home_screen.dart';
import 'package:flutter_application_8/view/screeens/testpage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/view/componenets/googl_button.dart';
import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  void googleSign() {
    // Implement Google Sign-In functionality here
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

 void register(BuildContext context) async {
  final _auth = AuthService();

  // Check for empty fields or null image
  if (nameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwordController.text.isEmpty ||
      confirmPasswordController.text.isEmpty ||
      _image == null) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text('Error'),
              content: Text('Please fill all fields and select an image.'),
            ));
    return;
  }

  // Check if passwords match
  if (passwordController.text != confirmPasswordController.text) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Passwords don't match"),
            ));
    return;
  }

  try {
    // Attempt to sign up
    UserCredential? userCredential = await _auth.signUpWithEmailAndPassword(
      emailController.text,
      passwordController.text,
      nameController.text,
      _image!,
    );
    print("SignUp Success");

    // Check if sign up was successful
    if (userCredential != null) {
      // Fetch current user and navigate to home screen
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        print(user.photoURL);
        print(user);
        print(user.uid);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthGate()),
        );
      } else {
        throw FirebaseAuthException(
            code: 'user-null', message: 'Failed to retrieve user after sign up.');
      }
    } else {
      throw FirebaseAuthException(
          code: 'signup-failed', message: 'Sign up failed for unknown reasons.');
    }
  } catch (e) {
    // Display error message
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
            ));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double avatarRadius = constraints.maxWidth * 0.15;
              double spacing = constraints.maxWidth * 0.02;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Let's Create An Account For You!",
                    style: TextStyle(
                      fontSize: constraints.maxWidth * 0.05,
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: spacing),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: avatarRadius,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                              Icons.person,
                              size: avatarRadius,
                              
                            )
                          : null,
                    ),
                  ),
                  SizedBox(height: spacing),
                  Textfieldd(
                    textcont: nameController,
                    obs: false,
                    hinttexxt: "Username",
                  ),
                  SizedBox(height: spacing),
                  Textfieldd(
                    textcont: emailController,
                    obs: false,
                    hinttexxt: "Email",
                  ),
                  SizedBox(height: spacing),
                  Textfieldd(
                    textcont: passwordController,
                    obs: true,
                    hinttexxt: "Password",
                  ),
                  SizedBox(height: spacing),
                  Textfieldd(
                    textcont: confirmPasswordController,
                    obs: true,
                    hinttexxt: "Confirm Password",
                  ),
                  SizedBox(height: spacing),
                  Mybutton(
                    textt: "Register",
                    ontapp: () => register(context),
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an Account?",
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: spacing),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login now",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("_______________",
                          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                      const Text("or continue with",
                          style: TextStyle(color: Colors.grey)),
                      Text("_______________",
                          style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                  SizedBox(height: spacing),
                  GoogleButton(textt: "Sign Up", ontapp: googleSign),
                  
              Text('admin')

                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
