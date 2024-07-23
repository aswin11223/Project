import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiscoverPeopleScreen extends StatefulWidget {
  DiscoverPeopleScreen({super.key});

  @override
  State<DiscoverPeopleScreen> createState() => _DiscoverPeopleScreenState();
}

class _DiscoverPeopleScreenState extends State<DiscoverPeopleScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Discover People",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('user').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Error"));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No users found"));
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildScreenItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildScreenItem(DocumentSnapshot document) {
    Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
    if (data == null) {
      return Container(); // or handle the null data case accordingly
    }
    String? email = data["email"] as String?;
    if (email != null && _auth.currentUser?.email != email) {
      return ListTile(
        title: Text(email),
       
      );
    } else {
      return Container();
    }
  }
}
