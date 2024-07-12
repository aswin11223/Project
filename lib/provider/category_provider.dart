import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_product.dart';
import 'package:flutter_application_8/model/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Product> _products = [];

  List<Category> get categories => _categories;
  List<Product> get products => _products;

  CategoryProvider() {
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    var snapshot = await FirebaseFirestore.instance.collection('categories').get();
    _categories = snapshot.docs.map((doc) => Category(
      id: doc.id,
      name: doc['name'],
      imageUrl: doc['imageUrl'],
    )).toList();
    notifyListeners();
  }

  Future<void> addCategory(String name, String imageUrl) async {
    await FirebaseFirestore.instance.collection('categories').add({
      'name': name,
      'imageUrl': imageUrl,
    });
    fetchCategories();
  }

  Future<void> fetchProducts() async {
    var snapshot = await FirebaseFirestore.instance.collection('products').get();
    _products = snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    notifyListeners();
  }

  Future<void> addProduct(Product product, File imageFile) async {
    final storageRef = FirebaseStorage.instance.ref().child('product_images').child('${product.id}.jpg');
    await storageRef.putFile(imageFile);
    final imageUrl = await storageRef.getDownloadURL();

    final newProduct = Product(
      id: product.id,
      categoryId: product.categoryId,
      name: product.name,
      description: product.description,
      artistName: product.artistName,
      imageUrl: imageUrl,
      price: product.price,
      userid: FirebaseAuth.instance.currentUser!.uid,
    );

    await FirebaseFirestore.instance.collection('products').add(newProduct.toMap());
    fetchProducts();
  }

  List<Product> productsByCategory(String categoryId) {
    return _products.where((product) => product.categoryId == categoryId).toList();
  }

  List<Product> productsByUser(String userId) {
    return _products.where((product) => product.userid == userId).toList();
  }

  Future<void> deleteProduct(String productId) async {
    await FirebaseFirestore.instance.collection('products').doc(productId).delete();
    fetchProducts();
  }

  Future<void> refreshCategories() async {
    await fetchCategories();
  }



}


