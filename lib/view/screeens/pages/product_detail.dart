import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/cartmodel.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/details_page.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final String art;
  final String imageUrl;
  final String description;
  final double price;
  final String artist;
  
   ProductDetail({super.key,required this.art,required this.imageUrl,required this.description,required this.price,required this.artist});
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          
          children: [
            
          
              
              DetailProduct(artname:art,imageUrl:imageUrl ,description:description ,text: " Add to Cart",onTap: (){

                     final cartprovider=Provider.of<Cartprovider>(context,listen: false);
                     //add current product to the  cart
                     cartprovider.addtocart(Cartitem(artname: art, imageurl: imageUrl, price: price,artist:artist ));
                     //show a snackbar
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Add to Cart")));

              },),
              
            
        
          ],
        ),
      ),
    );
  }
}