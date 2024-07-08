import 'package:flutter/material.dart';

class DetailProduct extends StatelessWidget {
  final String artname;
  final String imageUrl;
  final String description;

  const DetailProduct({
    super.key,
    required this.artname,
    required this.imageUrl,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return Column(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
          color: Theme.of(context).colorScheme.secondary,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: screenHeight * 0.49,
                width: screenWidth,
                color: Colors.black87,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.07),
                  child: Text(
                    artname,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(35),
                  ),
                ),
                height: screenHeight * 0.4,
                width: screenWidth,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: screenHeight * 0.1, width: screenWidth * 0.13),
                        Container(
                          width: screenWidth * 0.27,
                          height: screenHeight * 0.05,
                          child: Text(
                            "About",
                            style: TextStyle(
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: screenWidth * 0.13),
                                Container(
                                  width: screenWidth * 0.67,
                                  height: screenHeight * 0.12,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      description,
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                top: screenHeight * 0.06,
                child: Container(
                  width: screenWidth * 0.93,
                  height: screenHeight * 0.45,
                  color: Colors.amber,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
