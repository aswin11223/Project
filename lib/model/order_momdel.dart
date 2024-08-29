import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/provider/cartprovider.dart';

class Order {
  final List<Product> items;
  final double totalPrice;
  final String name;
  final String phone;
  final String email;
  final String address;

  final String id;
  final String pincode;
  final String state; 

  Order({
    required this.pincode,
    required this.state,
    required this.items,
    required this.totalPrice,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    
    this.id = '',
  });
}
