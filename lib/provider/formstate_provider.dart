import 'package:flutter/material.dart';

class FormStateProvider with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void clearControllers() {
    nameController.clear();
    imageUrlController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }
}
