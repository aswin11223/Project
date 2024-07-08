

import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  String textt;
  final void Function()? ontapp;
  Mybutton({super.key, required this.textt, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapp,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        width: 500,
        height: 60,
        child: Center(
            child: Text(
          textt,
          style: TextStyle(
              
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary),
        )),
      ),
    );
  }
}
