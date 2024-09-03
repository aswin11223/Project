import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/user_model.dart';
import 'package:flutter_application_8/provider/auth/authservice.dart';
import 'package:flutter_application_8/provider/category_provider.dart';
import 'package:flutter_application_8/view/componenets/profilecomponents/profile_post.dart';
import 'package:flutter_application_8/view/screeens/adminpanel/adminlogin.dart';
import 'package:flutter_application_8/view/screeens/pages/add_product.dart';
import 'package:flutter_application_8/view/screeens/pages/add_user_daetails.dart';
import 'package:flutter_application_8/view/screeens/pages/setting_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: true);
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userProducts = categoryProvider.productsByUser(userId);

    return FutureBuilder<UserModel?>(
      future: AuthService().fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading profile'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('No user data found'));
        }

        final user = snapshot.data!;

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
              IconButton(onPressed: (){
             Navigator.push(context, PageTransition(child: Adminpanel(), type:PageTransitionType.bottomToTop));

              }, icon:Icon(Icons.person)),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
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
                      backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/029/364/941/small/3d-carton-of-boy-going-to-school-ai-photo.jpg'),
                      radius: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.Username,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.email,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 5),
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
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                                  SnackBar(
                                      content:
                                          Text('Error deleting product: $e')),
                                );
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
