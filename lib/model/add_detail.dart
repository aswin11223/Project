import 'package:cloud_firestore/cloud_firestore.dart';

class AddDetail {
  final String id;
  final String name;
  final String image;

  AddDetail({
    required this.id,
    required this.name,
    required this.image,
  });

  factory AddDetail.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AddDetail(
      id: doc.id,
      name: data['name'] ?? '',
      image: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': image,
    };
  }
}
