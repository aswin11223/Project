import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/provider/discover/discover_people.dart';

import 'package:flutter_application_8/model/user_model.dart';
import 'package:flutter_application_8/view/componenets/googl_button.dart';
import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';

import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void googleSign() {
    // Implement Google Sign-In functionality here
  }

  void register(BuildContext context) async {
    final _auth = AuthService();
    if (passwordController.text == confirmPasswordController.text) {
      try {
        UserCredential userCredential = await _auth.signUpWithEmailAndPassword(
            emailController.text, passwordController.text);

        // Add user to Firestore and refresh UserProvider
        if (userCredential.user != null) {
          final user = Usermodel(
            id: userCredential.user!.uid,
            name: nameController.text,
            folowcount: 0,
            profilephoto: '',
          );
          await _auth.saveuserdeatils(user);

          // Refresh the UserProvider
          await Provider.of<UserProvider>(context, listen: false).fetchUsers();
        }

        // Navigate to the next screen or show success message
        Navigator.pop(context);

      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Error'),
                  content: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords don't match"),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Let's Create An Account For You!",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: nameController,
                obs: false,
                hinttexxt: "Name",
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: emailController,
                obs: false,
                hinttexxt: "Email",
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: passwordController,
                obs: true,
                hinttexxt: "Password",
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: confirmPasswordController,
                obs: true,
                hinttexxt: "Confirm Password",
              ),
              const SizedBox(height: 15),
              Mybutton(
                textt: "Register",
                ontapp: () => register(context),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Login now",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("_______________", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  const Text("or continue with", style: TextStyle(color: Colors.grey)),
                  Text("_______________", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                ],
              ),
              const SizedBox(height: 20),
              GoogleButton(textt: "Sign Up", ontapp: googleSign),
            ],
          ),
        ),
      ),
    );
  }
}
