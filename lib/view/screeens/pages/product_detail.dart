import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/details_page.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final String art;
  final String imageUrl;
  final String description;
  final double price;
  final String artist;

  ProductDetail({
    Key? key,
    required this.art,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DetailProduct(
              artname: art,
              imageUrl: imageUrl,
              description: description,
              text: "Add to Cart",
              onTap: () {
                final cartProvider = Provider.of<CartProvider>(context, listen: false);
                final productToAdd = Product(
                  id: '', // Generate or assign a unique ID for the product
                  categoryId: '', // Provide the category ID if needed
                  name: art,
                  artistName: artist,
                  description: description,
                  imageUrl: imageUrl,
                  price: price,
                  userid: '', // Set the user ID if needed
                );
                cartProvider.addToCart(productToAdd);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to Cart")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
