import 'package:flutter/material.dart';

class ProfilePost extends StatelessWidget {
  final String name;
  final String price;
  final String imageurl;
  final VoidCallback ontap;
  final VoidCallback ontapp;
  final VoidCallback onLike;
  final VoidCallback onDelete;
  final String id;
  final bool isLiked; // Add this field to indicate the like state
  final int likeCount; // Add this field to indicate the like count

  ProfilePost({
    required this.id,
    required this.name,
    required this.price,
    required this.imageurl,
    required this.ontap,
    required this.ontapp,
    required this.onLike,
    required this.onDelete,
    required this.isLiked, // Include in constructor
    required this.likeCount, // Include in constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(imageurl, fit: BoxFit.cover, height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('\$$price'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.grey,
                          ),
                          onPressed: onLike,
                        ),
                        Text('$likeCount'),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
