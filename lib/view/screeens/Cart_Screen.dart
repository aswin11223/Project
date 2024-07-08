import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';
import 'package:flutter_application_8/model/add_product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cartprovider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text('Your Cart:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 25),),
      ),
      body: cartProvider.items.isEmpty
          ? Center(
              child: Text('No items in the cart'),
            )
          : ListView.builder(
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final item = cartProvider.items[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.network(
                      item.imageurl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(item.artist),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ArtNmae: ${item.artname}'),
                        Text('Price: \$${item.price.toStringAsFixed(2)}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        cartProvider.removefromcart(item);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartProvider.items.isEmpty
          ? null
          : Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${cartProvider.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
    );
  }
}
