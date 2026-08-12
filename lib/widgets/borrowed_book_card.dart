import 'package:flutter/material.dart';

class BorrowedBookCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String category;
  final String borrower;
  final String borrowedDate;
  final String dueDate;

  const BorrowedBookCard({
    super.key,
    required this.image,
    required this.title,
    required this.author,
    required this.category,
    required this.borrower,
    required this.borrowedDate,
    required this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Image.asset(image, width: 52, height: 78, fit: BoxFit.cover),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
              Text(author, style: TextStyle(fontSize: 10, color: Colors.grey)),
              Text(
                category,
                style: TextStyle(
                  fontSize: 10,
                  color: Color.fromARGB(255, 0, 12, 143),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
