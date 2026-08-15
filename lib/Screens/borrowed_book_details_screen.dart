import 'package:flutter/material.dart';
import 'package:wayko/widgets/borrowed_book_header.dart';
import 'package:wayko/widgets/borrower_info_card.dart';
import 'package:wayko/widgets/borrowed_book_button.dart';

class BorrowedBookDetailsScreen extends StatefulWidget {
  const BorrowedBookDetailsScreen({super.key});

  @override
  State<BorrowedBookDetailsScreen> createState() =>
      _BorrowedBookDetailsScreenState();
}

class _BorrowedBookDetailsScreenState extends State<BorrowedBookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Borrowed Book Details")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            BorrowedBookHeader(
              image: "assets/images/book3.jpg",
              title: "I too had a love story",
              author: "Ravinder Singh",
              category: "Fiction",
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Borrower Information",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 12, 143),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 5),
            BorrowerInfoCard(
              borrowerName: "Mohammed Nafil",
              contact: "+91 77349 78934",
              borrowDate: "01 August 2026",
              returnDate: "05 August 2026",
              notes: "Take care this book",
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BorrowedBookButton(onReturn: () {
            Navigator.pop(context);
          }, onEdit: () {}),
        ),
      ),
    );
  }
}
