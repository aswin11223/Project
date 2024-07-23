import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Darkmode extends StatelessWidget {
  final void Function(bool)? ontapp;
  final bool val;
  const Darkmode({super.key,required this.ontapp,required this.val});

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
        SizedBox(width: 20,),
        Icon(Icons.dark_mode),
        Text('DarkMode',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
        SizedBox(width: 150,),
        CupertinoSwitch(value: val, onChanged: ontapp),
      ],
    );
  }
}