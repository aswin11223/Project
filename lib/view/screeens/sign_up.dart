
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/view/componenets/googl_button.dart';
import 'package:flutter_application_8/view/componenets/my_button.dart';
import 'package:flutter_application_8/view/componenets/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController email_con = TextEditingController();
  final TextEditingController passs_con = TextEditingController();
  final TextEditingController confirm_pass = TextEditingController();
   final TextEditingController name_con = TextEditingController();

  void Function()? onTap;

//password match ->create user

  RegisterPage({super.key, required this.onTap});
void googlesign(){

}


  void register(BuildContext context) {
    final _auth = Authservice();
    if (passs_con.text == confirm_pass.text) {
      try {
        _auth.signupwithemailandpassowrd(email_con.text, passs_con.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    }
//password not match ->tell user to fix it
    else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("password don't match"),
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
                "Lets Create An Account For You!",
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary,fontWeight:FontWeight.w800,),
              ),
              const SizedBox(
                height: 10,
              ),
              Textfieldd(
                textcont: name_con,
                obs: false,
                hinttexxt: "name",
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont:email_con,
                obs: false,
                hinttexxt: "email",
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: passs_con,
                obs: true,
                hinttexxt: "password",
              ),
              const SizedBox(height: 10),
              Textfieldd(
                textcont: confirm_pass,
                obs: true,
                hinttexxt: "confirm  password",
              ),
              const SizedBox(height: 15),
              Mybutton(
                textt: "Register",
                ontapp: () => register(context),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "All ready have an  Account?",
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
                      "login now",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
               Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("_______________",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                      const Text("or continue with",style: TextStyle(color:Colors.grey)),
          
                      Text("_______________",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                    ],
                  ),
                  const SizedBox(height: 20,),
          GoogleButton(textt:"signup" , ontapp: googlesign)
          
            ],
          ),
        ),
      ),
    );
  }
}
