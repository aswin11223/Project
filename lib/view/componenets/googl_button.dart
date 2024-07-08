

import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  String textt;
  final void Function()? ontapp;
  GoogleButton({super.key, required this.textt, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapp,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        width: 650,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Center(
              child: Container(
                width: 30,
                height: 30,
                child: Image.network("https://clipartcraft.com/images/google-logo-transparent.png",)),
            ),
              SizedBox(width: 5,),

            Center(
                child: Text(
              textt,
              style: TextStyle(
                  
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,)
            )),
          ],
        ),
      ),
    );
  }
}
