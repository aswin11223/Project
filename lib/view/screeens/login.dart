import 'package:flutter/material.dart';

import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/provider/auth/google_sign.dart';
import 'package:flutter_application_8/view/componenets/googl_button.dart';
import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';

class Login extends StatelessWidget {
  final TextEditingController email_con = TextEditingController();
  final TextEditingController pass_con = TextEditingController();
  void Function()? onTap;

//login
  void login(BuildContext context) async {
    final authservice = Authservice();
    try {
      await authservice.signinwithemailpassword(email_con.text, pass_con.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  void googlesignin(BuildContext context) async {
    final authser = Authservice();
    try {
      await authser.signinwithgoogle();
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("error sign in wiith google"),
              ));
    }
  }

  Login({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "welcome back,you have been missed!",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Textfieldd(
              textcont: email_con,
              obs: false,
              hinttexxt: "Email",
            ),
            Textfieldd(
              textcont: pass_con,
              obs: true,
              hinttexxt: "password",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    child: const Text(
                  "forgot password?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 15),
            Mybutton(textt: "Login", ontapp: () => login(context)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Not a member?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: onTap,
                  child: const Text(
                    "Signup Now",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "_______________",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                const Text("or continue with",
                    style: TextStyle(color: Colors.grey)),
                Text(
                  "_______________",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GoogleButton(textt: "Google", ontapp: () => googlesignin(context))
          ],
        ),
      ),
    );
  }
}
