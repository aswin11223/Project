import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/back_arrow.dart';

class Profilecom extends StatelessWidget {
  final File? image;
  final void Function()? ontap;

  Profilecom({
    required this.image,
    required this.ontap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
  
        
        const SizedBox(height: 60),
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.transparent,
              ),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey[600],
                      ),
                    ),
            ),
            Positioned(
              top: 70,
              left: 83,
              child: IconButton(
                onPressed: ontap,
                icon: const Icon(
                  Icons.add_a_photo,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
