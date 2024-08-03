import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/order_provider.dart';
import 'package:flutter_application_8/provider/orderprivedr.dart';

import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProviderr>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('empty'));
          } else {
            return ListView.builder(
              itemCount: orderProvider.orders.length,
              itemBuilder: (context, index) {
                final order = orderProvider.orders[index];
                return ListTile(
                  title: Text("Order ID: ${order.orderId}"),
                  subtitle: Text("Address: ${order.address}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
