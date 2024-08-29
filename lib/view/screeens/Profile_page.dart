import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/view/componenets/profilecomponents/profile_post.dart';
import 'package:flutter_application_8/view/screeens/pages/add_product.dart';
import 'package:flutter_application_8/view/screeens/pages/setting_page.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final String usere;
  final String image;

  const ProfilePage({
    Key? key,
    required this.usere,
    required this.email,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider >(context,listen: true);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userProducts = categoryProvider.productsByUser(userId);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade600,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Setting(name: usere),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
              size: 30,
            ),
          ),
        ],
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Profile Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 50,
                ),
                const SizedBox(height: 10),
                Text(
                  usere,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Your posts:",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
          // List of User's Products
          Expanded(
  child: userProducts.isEmpty
      ? const Center(
          child: Text(
            'No posts available',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        )
      : ListView.builder(
          itemCount: userProducts.length,
          itemBuilder: (context, index) {
            final product = userProducts[index];
            return ProfilePost(
              imageUrl: product.imageUrl,
              onDelete: () async {
                try {
                  await categoryProvider.deleteProduct(product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Product deleted successfully')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting product: $e')),
                  );
                }
              },
            );
          },
        ),
)

        ],
      ),
    );
  }
}
