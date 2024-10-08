import 'dart:ffi';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../model/add_product.dart';
import '../model/category.dart';
import '../provider/category_provider.dart';
import 'package:provider/provider.dart';

class AddProductProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final artistNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
 
  File? _image;
  String? _selectedCategoryId;
  bool _isLoading = false;  // Loading state

  File? get image => _image;
  String? get selectedCategoryId => _selectedCategoryId;
  bool get isLoading => _isLoading;  // Expose loading state

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _image = pickedFile != null ? File(pickedFile.path) : null;
    notifyListeners();
  }

  void selectCategory(String? categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }

  Future<void> addProduct(BuildContext context, List<Category> categories) async {
    if (_selectedCategoryId != null &&
        nameController.text.isNotEmpty &&
        artistNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        _image != null) {
      
      _isLoading = true;  // Set loading to true
      notifyListeners();  // Notify listeners to update the UI

      try {
        final product = Product(
          userid: FirebaseAuth.instance.currentUser!.uid,
          id: DateTime.now().toString(),
          categoryId: _selectedCategoryId!,
          name: nameController.text,
          artistName: artistNameController.text,
          description: descriptionController.text,
          imageUrl: '', // You need to upload the image and get URL
          price: double.parse(priceController.text),
        );

        await Provider.of<CategoryProvider>(context, listen: false).addProduct(product, _image!);
        disposeControllers(); // Dispose controllers after adding product
        Navigator.of(context).pop();
      } finally {
        _isLoading = false;  // Set loading to false
        notifyListeners();  // Notify listeners to update the UI
      }
    }
  }

  void disposeControllers() {
    nameController.clear();
    artistNameController.clear();
    descriptionController.clear();
    priceController.clear();
    _image = null;
    _selectedCategoryId = null;
    notifyListeners();
  }
}
