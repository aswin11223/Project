import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderProviderr with ChangeNotifier {
  final List<orderr> _orders = [];

  List<orderr> get orders => _orders;

  Future<void> addOrder(orderr order) async {
    await FirebaseFirestore.instance.collection('orders').add(order.toMap());
    _orders.add(order);
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('orders').get();
    _orders.clear();
    for (var doc in snapshot.docs) {
      _orders.add(orderr.fromDocument(doc));
    }
    notifyListeners();
  }

  Future<void> removeOrder(String orderId) async {
    final orderDoc = await FirebaseFirestore.instance
        .collection('orders')
        .where('orderId', isEqualTo: orderId)
        .get();
    if (orderDoc.docs.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderDoc.docs.first.id)
          .delete();
      _orders.removeWhere((order) => order.orderId == orderId);
      notifyListeners();
    }
  }
}

class orderr {
  final String orderId;
  final String address;
  final String phonenum;
  final String price;

  orderr({required this.orderId, required this.address, required this.phonenum,required this.price});

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'address': address,
      'phoneno': phonenum,
    };
  }

  static orderr fromDocument(DocumentSnapshot doc) {
    return orderr(
       price: doc['price'] ?? '',
      orderId: doc['orderId'] ?? '', // Handle null values
      address: doc['address'] ?? '', // Handle null values
      phonenum: doc['phoneno'] ?? '', // Handle null values
    );
  }
}
