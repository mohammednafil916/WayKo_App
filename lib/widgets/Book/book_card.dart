import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';

class BookCard extends StatelessWidget {
  final Uint8List? image;
  final String title;
  final String author;
  final String category;
  final String available;

  const BookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
    required this.available,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.bookDetails);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: image != null
                  ? Image.memory(
                      image!,
                      width: 65,
                      height: 90,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 65,
                      height: 90,
                      color: Colors.grey.shade200,
                      child: Icon(Icons.book, size: 35, color: Colors.grey),
                    ),
            ),
            SizedBox(width: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text(
                  author,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 0, 12, 143),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Available $available",
                  style: TextStyle(fontSize: 13, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
