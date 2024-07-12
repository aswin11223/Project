import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class Profileprovider extends ChangeNotifier {
  final _picker = ImagePicker();
  File? _image;

  File? get image => _image;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    _image = pickedFile != null ? File(pickedFile.path) : null;
    notifyListeners();
  }

  @override
  void dispose() {
    _image = null;
    super.dispose();
  }
}
