import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/image_addbutton.dart';

class PickImage extends StatelessWidget {
  final void Function()? ontap;
  final String text;
  const PickImage({super.key, required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 280,
        height: 40,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: Row(
          children: [
            SizedBox(
              width: 170,
            ),
            const Icon(
              Icons.image,
              size: 15,
            ),
            Center(
                child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w800),
            )),
            const SizedBox(
              width: 5,
            ),
            ImageAdd(ontapressed: ontap)
          ],
        ),
      ),
    );
  }
}
