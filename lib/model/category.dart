import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  

  Category({
    required this.name,
    required this.imageUrl,
    required this.id,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Category(
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      id: data['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id'  :id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
