import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String category;
  final String available;
  final VoidCallback? onClick;
  const BookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
    required this.available,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                image,
                width: 65,
                height: 90,
                fit: BoxFit.cover,
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
