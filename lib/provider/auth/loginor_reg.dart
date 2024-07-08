import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/screeens/login.dart';
import 'package:flutter_application_8/view/screeens/sign_up.dart';


class loginorreg extends StatefulWidget {
   loginorreg({super.key});

  @override
  State<loginorreg> createState() => _loginorregState();
}

class _loginorregState extends State<loginorreg> {
  bool showloginpage=true;

  void   togglepages (){
    setState(() {
      showloginpage=!showloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showloginpage){
      return Login(onTap: togglepages);

    }else{
      return RegisterPage(onTap: togglepages);
    }
  }
}