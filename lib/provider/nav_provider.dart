import 'package:flutter/material.dart';

class NavProvider with ChangeNotifier {
  int _selectedIndex = 0;
  String? _categoryId; // Add categoryId

  int get selectedIndex => _selectedIndex;
  String? get categoryId => _categoryId; // Getter for categoryId

  void setIndex(int index, {String? categoryId}) {
    _selectedIndex = index;
    _categoryId = categoryId; // Set categoryId when changing index
    notifyListeners();
  }
}
