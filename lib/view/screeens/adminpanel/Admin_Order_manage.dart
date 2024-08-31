import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/notification_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_8/provider/orderprivedr.dart';


class AdminOrderManagementPage extends StatelessWidget {
  const AdminOrderManagementPage({super.key});

  void _cancelOrder(BuildContext context, String orderId, String userId) async {
    // Delete order from Firestore
    await FirebaseFirestore.instance.collection('orders').doc(orderId).delete();

    // Add a notification for the user
    await FirebaseFirestore.instance.collection('notifications').add({
      'userId': userId,
      'message': 'Your order $orderId has been canceled.',
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Notify the provider about the new notification
    Provider.of<NotificationProvider>(context, listen: false).fetchNotifications(userId);

    // Show a snackbar message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order $orderId canceled. Notification sent to user $userId.')),
    );

    // Optionally, remove the order from the provider's state
    Provider.of<OrderProviderr>(context, listen: false).removeOrder(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Admin Order Management',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching orders'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order.id;
              final data = order.data() as Map<String, dynamic>;

              // Provide default values if any field is null
              final userId = data['userId'] ?? 'Unknown User';
              final address = data['address'] ?? 'No Address';
              final pricer = (data['price'] != null) ? data['price'].toString():'0';
              final phone = data['phoneno'] ?? 'No Phone Number';

              return ListTile(
                title: Text('Order ID: $orderId'),
                subtitle: Text('Address: $address\nPrice: $pricer\nPhone: $phone'),
                trailing: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () => _cancelOrder(context, orderId, userId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
