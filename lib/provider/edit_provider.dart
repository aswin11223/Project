import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/model/add_detail.dart';

class AddDetailProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  AddDetail? _currentDetail;

  AddDetail? get currentDetail => _currentDetail;

  Future<void> addDetail(AddDetail detail, File imageFile) async {
    try {
      // Upload image to Firebase Storage
      final ref = _storage.ref().child('detail_images').child('${detail.id}.jpg');
      await ref.putFile(imageFile);
      final imageUrl = await ref.getDownloadURL();

      // Update the detail object with the image URL
      final newDetail = AddDetail(
        id: detail.id,
        name: detail.name,
        image: imageUrl,
      );

      // Save detail to Firestore
      await _firestore.collection('details').doc(detail.id).set(newDetail.toMap());

      _currentDetail = newDetail;
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
      final updatedDetail = AddDetail(
        id: detail.id,
        name: detail.name,
        image: imageUrl ?? detail.image,
      );

      // Save or update the detail in Firestore
      await _firestore.collection('details').doc(detail.id).update(updatedDetail.toMap());

      _currentDetail = updatedDetail;
      notifyListeners();
    } catch (e) {
      throw Exception('Error updating detail: $e');
    }
  }

  Future<void> getDetail(String id) async {
    try {
      final doc = await _firestore.collection('details').doc(id).get();

      if (doc.exists) {
        _currentDetail = AddDetail.fromFirestore(doc);
        notifyListeners();
      } else {
        throw Exception('Detail not found');
      }
    } catch (e) {
      throw Exception('Error fetching detail: $e');
    }
  }

  Future<List<AddDetail>> getAllDetails() async {
    try {
      final querySnapshot = await _firestore.collection('details').get();
      final details = querySnapshot.docs
          .map((doc) => AddDetail.fromFirestore(doc))
          .toList();
      return details;
    } catch (e) {
      throw Exception('Error fetching details: $e');
    }
  }
}
