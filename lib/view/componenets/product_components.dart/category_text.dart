import 'package:flutter/material.dart';

class cat extends StatelessWidget {
 final String text;
  const cat({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),);
  }
}