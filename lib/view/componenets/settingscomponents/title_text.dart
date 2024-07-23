import 'package:flutter/material.dart';

class Tittle extends StatelessWidget {
  final String text;

  const Tittle({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontWeight: FontWeight.w800),);
  }
}