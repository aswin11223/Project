import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/profileprovider/like_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/provider/profileprovider/profileprovider.dart';
import 'package:flutter_application_8/view/componenets/profilecomponents/profile_post.dart';
import 'package:flutter_application_8/view/componenets/profilecomponents/profilecomp.dart';

class Profile extends StatelessWidget {
  final String categoryId;

  Profile({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<Profileprovider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, size: 30)),
        ],
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          Profilecom(
            image: profileProvider.image,
            ontap: () {
              profileProvider.pickImage();
            },
          ),
          Consumer<CategoryProvider>(
            builder: (context, provider, child) {
              final userProducts = provider.productsByUser(user?.uid ?? '');

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const SizedBox(width: 20),
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
                          itemCount: userProducts.length,
                          itemBuilder: (context, index) {
                            final product = userProducts[index];
                            return Consumer<Like>(
                              builder: (context, likeProvider, child) {
                                final isLiked = likeProvider.isLiked(product.id);
                                final likeCount = likeProvider.getLikeCount(product.id);
                                return ProfilePost(
                                  name: product.name,
                                  price: product.price.toString(),
                                  imageurl: product.imageUrl,
                                  ontap: () {},
                                  ontapp: () {},
                                  onLike: () {
                                    likeProvider.toggleLike(product.id);
                                  },
                                  onDelete: () {},
                                  id: product.userid,
                                  isLiked: isLiked, // Pass the isLiked state
                                  likeCount: likeCount, // Pass the likeCount state
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
