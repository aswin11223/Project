import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_8/model/user_model.dart';


class UserProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Usermodel> _users = [];

  List<Usermodel> get users => _users;

  UserProvider() {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final snapshot = await _firestore.collection('user').get();
      _users = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Usermodel(
          id: doc.id,
          name: data['name'] ?? '',
          folowcount: data['count'] ?? 0, profilephoto: '',
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void addUser(Usermodel user) {
    _users.add(user);
    notifyListeners();
  }

  void toggleFollow(String userId) {
    final user = _users.firstWhere((user) => user.id == userId);
    if (user.isfollowed) {
      user.folowcount--;
    } else {
      user.folowcount++;
    }
    user.isfollowed = !user.isfollowed;
    notifyListeners();
  }
}
