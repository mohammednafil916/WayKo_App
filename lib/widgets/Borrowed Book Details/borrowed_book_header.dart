import 'dart:typed_data';
import 'package:flutter/material.dart';

class BorrowedBookHeader extends StatelessWidget {
  final Uint8List? image;
  final String title;
  final String author;
  final String category;

  const BorrowedBookHeader({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SizedBox(
            height: 150,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image != null
                  ? Image.memory(image!, fit: BoxFit.cover)
                  : Container(
                      color: Colors.grey.shade200,
                      child: Icon(Icons.book, size: 40, color: Colors.grey),
                    ),
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 12, 143),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                author,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Text(
                category,
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
