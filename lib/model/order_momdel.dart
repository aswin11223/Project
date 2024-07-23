import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';

class Order {
  final List<Product> items;
  final double totalPrice;
  final String name;
  final String phone;
  final String email;
  final String address;
  final String location;
  final String id;

  Order({
    required this.items,
    required this.totalPrice,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.location,
    this.id = '',
  });
}
