import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/content_text.dart';
import 'package:flutter_application_8/view/componenets/settingscomponents/title_text.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'About Artistry Hub',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              
                 Content(
                  text:
                      'Welcome to Artistry Hub, the ultimate platform for artists and art enthusiasts to connect, discover, and purchase unique artworks from around the world. Whether youre an emerging artist looking to showcase your talent or an art lover seeking the perfect piece to adorn your space, Artistry Hub provides a seamless and inspiring experience for all.',
                ),
              
              SizedBox(height: 20),
              Tittle(text: 'User-Friendly Interface'),
              SizedBox(height: 10),
              Content(
                text:
                    'avigate effortlessly through our intuitive app design. With easy-to-use search and filter options, finding the perfect artwork has never been easier. Enjoy a smooth browsing experience with high-quality images and detailed descriptions of each piece.',
              ),
              SizedBox(height: 20),
              Tittle(text: 'Secure Transactions'),
              SizedBox(height: 10),
              Content(
                text:
                    'Shop with confidence knowing that your transactions are secure.',
              ),
              SizedBox(height: 20),
              Tittle(text: 'Our Community'),
              SizedBox(height: 10),
              Content(
                text:
                    'Artistry Hub is more than just an app; its a community where creativity thrives and art is celebrated. Download Artistry Hub today and embark on your journey to discover and own beautiful art.',
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}