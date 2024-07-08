import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/addproductcomponents/image_addbutton.dart';

class ShowProducts extends StatelessWidget {
  final String name;
  final String price;
  final String imageurl;
  final void Function()? ontap;
  final void Function()? ontapp;

  const ShowProducts({
    Key? key,
    required this.ontap,
    required this.name,
    required this.price,
    required this.imageurl,
    required this.ontapp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: ontapp,
      child: Container(
        width: screenWidth * 0.4, // 40% of screen width
        height: screenHeight * 0.3, // 30% of screen height
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.inversePrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: screenWidth * 0.25, // Adjusted size
              height: screenWidth * 0.25, // Adjusted size
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  imageurl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04, // Adjusted size
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: screenWidth * 0.025, // Adjusted size
                color: Colors.black,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ImageAdd(ontapressed: ontap),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
