import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/details_page.dart';

class ProductDetail extends StatelessWidget {
  final String art;
  final String imageUrl;
  final String description;
  
  const ProductDetail({super.key,required this.art,required this.imageUrl,required this.description});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        
        children: [
          
        
            
            DetailProduct(artname:art,imageUrl:imageUrl ,description:description ,)
          

        ],
      ),
    );
  }
}