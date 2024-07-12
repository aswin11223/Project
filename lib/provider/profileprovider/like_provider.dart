import 'package:flutter/material.dart';

class Like extends ChangeNotifier {
  final Map<String, int> _likedItems = {};

  bool isLiked(String productId) {
    return _likedItems.containsKey(productId);
  }

  int getLikeCount(String productId) {
    return _likedItems[productId] ?? 0;
  }

  void toggleLike(String productId) {
    if (_likedItems.containsKey(productId)) {
      _likedItems[productId] = (_likedItems[productId]! - 1).clamp(0, double.infinity).toInt();
      if (_likedItems[productId] == 0) {
        _likedItems.remove(productId);
      }
    } else {
      _likedItems[productId] = 1;
    }
    notifyListeners();
  }
}
