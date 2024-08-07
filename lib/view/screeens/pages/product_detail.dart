import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/provider/profileprovider/like_provider.dart';
import 'package:flutter_application_8/view/componenets/buy_button.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/details_page.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final likeProvider = Provider.of<Like>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final isLiked = likeProvider.isLiked(product.id);
    final likeCount = likeProvider.getLikeCount(product.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name,style: TextStyle(fontSize: 25,fontWeight: FontWeight.w800),),
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.red : Colors.grey,
            ),
            onPressed: () async {
              await likeProvider.toggleLike(product.id);
            },
          ),
        ],
      ),
      body:
        
          DetailProduct(artname: product.artistName, imageUrl: product.imageUrl, description: product.description, buttonText: "add cart",onTap: (){
            final cartProvider = Provider.of<CartProvider>(context, listen: false);
                          final productToAdd = Product(
                            userid: product.userid,
                            id: product.id,
                            categoryId: product.categoryId,
                            name: product.name,
                            artistName: product.artistName,
                            description: product.description,
                            imageUrl: product.imageUrl,
                            price: product.price,
                            likeCount: likeCount,
                          );
                          cartProvider.addToCart(productToAdd);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Added to Cart")),
                          );
          },)
      
      );
    
  }
}
