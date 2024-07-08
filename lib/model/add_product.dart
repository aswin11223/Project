import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String artistName;
  final String description;
  final String imageUrl;
  final double price;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.artistName,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      id: data['id'] ?? '',
      categoryId: data['categoryId'] ?? '',
      name: data['name'] ?? '',
      artistName: data['artistName'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'artistName': artistName,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
