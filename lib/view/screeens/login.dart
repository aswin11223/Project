import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/view/componenets/googl_button.dart';

import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/adminlogin.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  void Function()? onTap;

  Login({super.key, required this.onTap});

  void login(BuildContext context) async {
    try {
      await _authService.signInWithEmailPassword(emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  void googleSignIn(BuildContext context) async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      showDialog(context: context,
        builder: (context) => const AlertDialog(
          title: Text("Error signing in with Google"),
        ),
      );
    }
  }

  void resetPassword(BuildContext context) async {
    try {
      await _authService.sendPasswordResetEmail(emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
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
              const SizedBox(height: 10),
              Text(
                "Welcome back, you have been missed!",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: emailController,
                obs: false,
                hinttexxt: "Email",
              ),
              Textfieldd(
                textcont: passwordController,
                obs: true,
                hinttexxt: "Password",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => resetPassword(context),
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 15),
              Mybutton(textt: "Login", ontapp: () => login(context)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      "Sign up now",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "_______________",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  const Text(
                    "or continue with",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "_______________",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GoogleButton(textt: "Google", ontapp: () => googleSignIn(context)),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
