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
}

class orderr {
  final String orderId;
  final String address;

  orderr({required this.orderId, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'address': address,
    };
  }

  static orderr fromDocument(DocumentSnapshot doc) {
    return orderr(
      orderId: doc['orderId'],
      address: doc['address'],
    );
  }
}
