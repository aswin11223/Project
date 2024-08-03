import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Like extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, int> _likedItems = {};
  Map<String, bool> _userLikedItems = {};

  Like() {
    _fetchLikeCounts();
    _fetchUserLikes();
  }

  void _fetchLikeCounts() async {
    final snapshot = await _firestore.collection('likes').get();
    final data = snapshot.docs.asMap().map((_, doc) {
      return MapEntry(doc.id, doc.data()['count'] as int);
    });
    _likedItems = data;
    notifyListeners();
  }

  void _fetchUserLikes() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _firestore
          .collection('user_likes')
          .doc(user.uid)
          .collection('liked_products')
          .get();
      final data = snapshot.docs.asMap().map((_, doc) {
        return MapEntry(doc.id, doc.data()['liked'] as bool);
      });
      _userLikedItems = data;
      notifyListeners();
    }
  }

  bool isLiked(String productId) {
    return _userLikedItems[productId] ?? false;
  }

  int getLikeCount(String productId) {
    return _likedItems[productId] ?? 0;
  }

  Future<void> toggleLike(String productId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    final userLikeDoc = _firestore
        .collection('user_likes')
        .doc(user.uid)
        .collection('liked_products')
        .doc(productId);

    final likeDoc = _firestore.collection('likes').doc(productId);

    final userLiked = _userLikedItems[productId] ?? false;
    final batch = _firestore.batch();

    if (userLiked) {
      // Unlike
      batch.delete(userLikeDoc);
      batch.update(likeDoc, {
        'count': FieldValue.increment(-1),
      });
      _userLikedItems[productId] = false;
      _likedItems[productId] = (_likedItems[productId]! - 1).clamp(0, double.infinity).toInt();
    } else {
      // Like
      batch.set(userLikeDoc, {'liked': true});
      batch.set(likeDoc, {
        'count': FieldValue.increment(1),
      }, SetOptions(merge: true));
      _userLikedItems[productId] = true;
      _likedItems[productId] = (_likedItems[productId] ?? 0) + 1;
    }

    await batch.commit();
    notifyListeners();
  }
}
