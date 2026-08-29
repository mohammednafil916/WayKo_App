import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/Models/borrow_model.dart';

class BorrowedBookCard extends StatelessWidget {
  final BorrowModel borrow;
  final Uint8List? image;
  final String title;
  final String author;
  final String category;
  final String borrower;
  final String borrowedDate;
  final String dueDate;

  const BorrowedBookCard({
    super.key,
    required this.borrow,
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
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.borrowedBookDetails,
          arguments: borrow,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            if (image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.memory(
                  image!,
                  width: 55,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(width: 30),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        author,
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 0, 12, 143),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Borrowed by",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        borrower,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        borrowedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Due on",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        dueDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
