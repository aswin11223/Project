import 'package:flutter/material.dart';
import 'package:flutter_application_8/services/adminauth.dart';
import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/admindashbord.dart';
import 'package:page_transition/page_transition.dart';

class Adminpanel extends StatelessWidget {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final AdminAuth adminAuth = AdminAuth();

  Adminpanel({Key? key}) : super(key: key);

  void login(BuildContext context) async {
    try {
      // Attempt to sign in using the admin credentials
      await adminAuth.signInWithEmailAndPassword(_email.text, _password.text);
      Navigator.pushReplacement(
        context,
        PageTransition(child:DashBoard(), type: PageTransitionType.rightToLeft),
      );
    } catch (e) {
      // Show an error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://devforum-uploads.s3.dualstack.us-east-2.amazonaws.com/uploads/original/4X/1/0/e/10e6c0a439e17280a6f3fa6ae059819af5517efd.png'),
            ),
            const SizedBox(height: 10),
            const Text('Admin', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
            const SizedBox(height: 20),
            Textfieldd(hinttexxt: 'Email', obs: false, textcont: _email),
            const SizedBox(height: 10),
            Textfieldd(hinttexxt: 'Password', obs: true, textcont: _password),
            const SizedBox(height: 20),
            Mybutton(textt: 'Login', ontapp: () {
              login(context);
            }),
          ],
        ),
      ),
    );
  }
}
