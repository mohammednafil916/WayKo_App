import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/Models/book_model.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.bookDetails, arguments: book);
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
              child: book.coverImage != null
                  ? Image.memory(
                      book.coverImage!,
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
                  book.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text(
                  book.author,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                Text(
                  book.category,
                  style: TextStyle(
                    fontSize: 13,
                    color: const Color.fromARGB(255, 0, 12, 143),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Available ${book.availableCopies}",
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
