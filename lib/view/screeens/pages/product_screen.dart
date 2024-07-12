import 'package:flutter/material.dart';
import 'package:flutter_application_8/view/componenets/back_arrow.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/category_text.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/details_page.dart';
import 'package:flutter_application_8/view/componenets/product_components.dart/product_screen.dart';
import 'package:flutter_application_8/view/screeens/pages/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_8/provider/category_provider.dart'; // Import the ShowProducts widget

class ProductListScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;

  const ProductListScreen({
    required this.categoryId,
    required this.categoryName,
    Key? key,
  }) : super(key: key);
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          final products = provider.productsByCategory(categoryId);

          if (products.isEmpty) {
            return const Center(child: Text('No products found.'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50,),
                Row(children: [
                  BackArrow(ontapressed: (){}),
                  const SizedBox(width: 20,),
                  cat(text: "products in ${categoryName}"),
                  
                ],),
                const SizedBox(height: 10), // Add some spacing between the text and the grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns in the grid
                      crossAxisSpacing: 20.0, // Spacing between columns
                      mainAxisSpacing: 20.0, // Spacing between rows
                      childAspectRatio: 3 / 4, // Aspect ratio of each grid item
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ShowProducts(
                        ontapp:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(art: product.name,imageUrl: product.imageUrl,description: product.description,price: product.price,artist: product.artistName,)));
                       
                        } ,
                        name: product.name,
                        price: product.price.toString(),
                        imageurl: product.imageUrl,
                        ontap: (){

                        
                        },
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
