import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_detail.dart';

class AddDetailProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> addDetail(AddDetail detail, File imageFile) async {
    try {
      // Upload image to Firebase Storage
      final ref = _storage.ref().child('detail_images').child('${detail.id}.jpg');
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();

      // Update the detail object with the image URL
      detail = AddDetail(
        id: detail.id,
        name: detail.name,
        image: imageUrl,
      );

      // Save detail to Firestore
      await _firestore.collection('details').doc(detail.id).set(detail.toMap());

      notifyListeners();
    } catch (e) {
      throw Exception('Error adding detail: $e');
    }
  }

  Future<void> updateDetail(AddDetail detail, File? imageFile) async {
    try {
      String? imageUrl;

      // If there's a new image, upload it and get the URL
      if (imageFile != null) {
        final ref = _storage.ref().child('detail_images').child('${detail.id}.jpg');
        await ref.putFile(imageFile);
        imageUrl = await ref.getDownloadURL();
      }

      // Update the detail object
      if (imageUrl != null) {
        detail = AddDetail(
          id: detail.id,
          name: detail.name,
          image: imageUrl,
        );
      }

      // Save or update the detail in Firestore
      await _firestore.collection('details').doc(detail.id).update(detail.toMap());

      notifyListeners();
    } catch (e) {
      throw Exception('Error updating detail: $e');
    }
  }
}
