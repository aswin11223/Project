import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/provider/profileprovider/like_provider.dart';
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
        title: Text(product.name),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                height: 300,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
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
                  child: const Text('Add to Cart'),
                ),
                Row(
                  children: [
                    const Text('Likes: '),
                    Text(
                      likeCount.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
