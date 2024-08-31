import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_8/provider/edit_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_8/model/add_detail.dart';


class AddDetailPage extends StatelessWidget {
  final AddDetail? detail;

  AddDetailPage({this.detail, Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  @override
  Widget build(BuildContext context) {
    if (detail != null) {
      _nameController.text = detail!.name;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          detail == null ? 'Add Detail' : 'Edit Detail',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16),
            _imageFile == null
                ? TextButton(
                    onPressed: () async {
                      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        _imageFile = File(pickedFile.path);
                      }
                    },
                    child: const Text('Pick an Image'),
                  )
                : Image.file(
                    _imageFile!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();
                if (name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Name cannot be empty')),
                  );
                  return;
                }

                final newDetail = AddDetail(
                  id: detail?.id ?? DateTime.now().toString(),
                  name: name,
                  image: '', // Placeholder, will be updated after image upload
                );

                try {
                  final provider = Provider.of<AddDetailProvider>(context, listen: false);

                  if (detail != null) {
                    await provider.updateDetail(newDetail, _imageFile);
                  } else {
                    if (_imageFile != null) {
                      await provider.addDetail(newDetail, _imageFile!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please pick an image')),
                      );
                    }
                  }

                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error saving detail: $e')),
                  );
                }
              },
              child: Text(detail == null ? 'Add Detail' : 'Update Detail'),
            ),
          ],
        ),
      ),
    );
  }
}
