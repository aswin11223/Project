import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/order_momdel.dart';


class OrderProvider with ChangeNotifier {
  Order? _currentOrder;

  Order? get currentOrder => _currentOrder;

  void placeOrder(Order order) {
    _currentOrder = order;
    notifyListeners();
  }
}
