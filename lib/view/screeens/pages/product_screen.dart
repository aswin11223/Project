import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/view/componenets/back_arrow.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/category_text.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/product_screen.dart';
import 'package:flutter_application_8/view/screeens/pages/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/provider/profileprovider/like_provider.dart';

class ProductListScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const ProductListScreen({
    required this.categoryId,
    required this.categoryName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<CategoryProvider, Like>(
        builder: (context, categoryProvider, likeProvider, child) {
          final products = categoryProvider.productsByCategory(categoryId);

          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Row(
                  children: [
                    BackArrow(
                      ontapressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 20),
                    cat(text: "Products in $categoryName"),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      final isLiked = likeProvider.isLiked(product.id);
                      final likeCount = likeProvider.getLikeCount(product.id);

                      return ShowProducts(
                        ontapp: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                
                              ),
                            ),
                          );
                        },
                        name: product.name,
                        price: product.price.toString(),
                        imageurl: product.imageUrl,
                        ontap: () {
                          final cartProvider = Provider.of<CartProvider>(context, listen: false);
                          final productToAdd = Product(
                            userid: '',
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
                        },
                        onLike: () async {
                          await likeProvider.toggleLike(product.id);
                        },
                        likeCount: likeCount,
                        isLiked: isLiked,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
