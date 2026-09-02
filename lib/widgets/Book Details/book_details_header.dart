import 'dart:typed_data';
import 'package:flutter/material.dart';

class BookDetailsHeader extends StatelessWidget {
  final Uint8List? image;
  final String title;
  final String author;
  final String category;
  final bool isFavorite;
  final VoidCallback onFavorite;

  const BookDetailsHeader({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
    required this.isFavorite,
    required this.onFavorite,
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
            child: image != null
                ? Image.memory(image!, fit: BoxFit.cover)
                : Container(
                    color: Colors.grey.shade200,
                    child: Icon(Icons.book, size: 40, color: Colors.grey),
                  ),
          ),
        ),

        SizedBox(width: 20),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              Text(
                author,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 3),

              Text(
                category,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: const EdgeInsets.all(4),
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
        ),

        // Favorite Button
        IconButton(
          onPressed: onFavorite,
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
