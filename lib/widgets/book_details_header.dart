import 'package:flutter/material.dart';

class BookDetailsHeader extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String category;
  final bool isFavorite;
  const BookDetailsHeader({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 30),
        Container(
          height: 125,
          width: 85,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              author,
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 3),
            Text(
              category,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                "In Library",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 200),
        IconButton(
          onPressed: () {},
          icon: Icon(
            isFavorite ? Icons.star : Icons.star_border,
            color: Colors.orange,
            size: 26,
          ),
        ),
      ],
    );
  }
}
