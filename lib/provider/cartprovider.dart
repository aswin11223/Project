import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProvider with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items => _items;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add product to the cart
  void addToCart(Product product) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // Add product to Firestore for the current user
      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .add(product.toMap());

      // Add product to local list
      _items.add(product);
      notifyListeners();
    }
  }

  // Remove product from the cart
  void removeFromCart(Product product) async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // Remove product from Firestore for the current user
      var snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .where('id', isEqualTo: product.id)
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      // Remove product from local list
      _items.remove(product);
      notifyListeners();
    }
  }

  // Calculate total price of items in the cart
  double get totalPrice {
    return _items.fold(0, (sum, item) => sum + item.price);
  }

  // Clear the cart
  void clearCart() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // Clear cart in Firestore for the current user
      var snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();

      for (var doc in snapshot.docs) {
        await doc.reference.delete();
      }

      // Clear local list
      _items.clear();
      notifyListeners();
    }
  }

  // Load cart items from Firestore
  Future<void> loadCartItems() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // Fetch the cart items for the user from Firestore
      var snapshot = await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('cart')
          .get();

      _items = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
      notifyListeners();
    }
  }
}
