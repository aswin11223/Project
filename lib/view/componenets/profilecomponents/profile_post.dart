import 'package:flutter/material.dart';

class ProfilePost extends StatelessWidget {
  final String id;
  final String imageurl;
  final VoidCallback onDelete;

  const ProfilePost({
    Key? key,
    required this.id,
    required this.imageurl,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(imageurl),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confirmed = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm Deletion'),
                  content: Text('Are you sure you want to delete this product?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );
              if (confirmed) {
                onDelete();
              }
            },
          ),
        ],
      ),
    );
  }
}
