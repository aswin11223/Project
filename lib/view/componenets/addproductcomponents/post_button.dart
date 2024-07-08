import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class PostButton extends StatelessWidget {
  final String text;
  final void Function()? ontap;

   PostButton({Key? key, required this.text, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define the width and height as a percentage of the screen size
    final buttonWidth = screenWidth * 0.8; // 80% of screen width
    final buttonHeight = screenHeight * 0.07; // 7% of screen height

    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
