import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String categoryId;
  final String name;
  final String artistName;
  final String description;
  final String imageUrl;
  final double price;
  final String userid;
  int likeCount;

  Product({
    required this.userid,
    required this.id,
    required this.categoryId,
    required this.name,
    required this.artistName,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.likeCount = 0,
  });

  // Factory method to create a Product object from a Firestore DocumentSnapshot
  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      userid: data['userid'] ?? '',
      id: data['id'] ?? '',
      categoryId: data['categoryId'] ?? '',
      name: data['name'] ?? '',
      artistName: data['artistName'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      likeCount: data['likeCount'] ?? 0,
    );
  }

  // Convert Product object to a Map for storing in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'artistName': artistName,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'likeCount': likeCount,
    };
  }
}
