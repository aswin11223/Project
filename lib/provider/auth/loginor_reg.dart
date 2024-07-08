import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/loginor_regprovider.dart';
import 'package:flutter_application_8/view/screeens/login.dart';
import 'package:flutter_application_8/view/screeens/sign_up.dart';
import 'package:provider/provider.dart';

class LOginReg extends StatelessWidget {
  const LOginReg({super.key});

  @override
  Widget build(BuildContext context) {
   if(Provider.of<Logorreg>(context).showloginpage){
    return Login(onTap: Provider.of<Logorreg>(context).togglepages);

   }else{
    return RegisterPage(onTap: Provider.of<Logorreg>(context).togglepages);

   }
  }
}




