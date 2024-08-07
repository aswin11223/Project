import 'package:flutter/material.dart';

class DetailProduct extends StatelessWidget {
  final String artname;
  final String imageUrl;
  final String description;
  final String buttonText;
  final VoidCallback? onTap;

  const DetailProduct({
    super.key,
    required this.artname,
    required this.imageUrl,
    required this.description,
    required this.buttonText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.5,
                color: theme.colorScheme.secondary,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: screenHeight * 0.49,
                      width: screenWidth,
                      color: Colors.black87,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.03),
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
              Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenHeight * 0.05),
                    Row(
                      children: [
                        SizedBox(width: screenWidth * 0.13),
                        Container(
                          width: screenWidth * 0.27,
                          child: Text(
                            "About",
                            style: TextStyle(
                              color: theme.colorScheme.inversePrimary,
                              fontSize: screenWidth * 0.06,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            description,
                            style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03), // Space between description and button
                          Center(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(24),
                                onTap: onTap,
                                splashColor: Colors.black87,
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(28),
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: onTap,
                                      child: Text(
                                        buttonText,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.05),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
