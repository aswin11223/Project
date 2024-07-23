import 'package:flutter/material.dart';

class Content extends StatelessWidget {
  final String text;
  const Content({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
  width: 300,
  height: 100,
  
  child: Text(text,style: TextStyle(fontWeight:FontWeight.w500),),
  );

  }
}