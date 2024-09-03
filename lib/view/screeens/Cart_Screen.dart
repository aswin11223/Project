import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/view/componenets/buy_button.dart';
import 'package:flutter_application_8/view/screeens/buy_page.dart';
import 'package:flutter_application_8/view/screeens/pages/buy_pages/order%20sumary.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final User? user = FirebaseAuth.instance.currentUser;
  


    void buy(){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderSummary(totalPrice: cartProvider.totalPrice,)),);
    }
 



    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text(
            'Your Cart:',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
          ),
        ),
        body: const Center(
          child: Text('Please log in to see your cart'),
        ),
      );
    }

    // Fetch cart items for the current user
    cartProvider.loadCartItems();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: const Text(
          'Your Cart:',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 25,
          ),
        ),
      ),
      body: cartProvider.items.isEmpty
          ? const Center(
              child: Text('No items in the cart'),
            )
          : ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      item.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.artistName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Art Name: ${item.name}'),
                        Text('Price: \$${item.price.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        cartProvider.removeFromCart(item);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartProvider.items.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Price:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 BuyButton(ontap: (){
                 buy();
                 }
                      )
                ],
              ),
            ),
    );
  }
}
