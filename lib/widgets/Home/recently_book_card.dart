import 'dart:typed_data';
import 'package:flutter/material.dart';

class RecentlyBookCard extends StatelessWidget {
  final Uint8List? image;
  final String title;
  final String category;

  const RecentlyBookCard({
    super.key,
    required this.image,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image != null
              ? Image.memory(
                  image!,
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 110,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Icon(Icons.book, size: 40, color: Colors.grey),
                ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 3),
          Text(
            category,
            style: TextStyle(fontSize: 12, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
