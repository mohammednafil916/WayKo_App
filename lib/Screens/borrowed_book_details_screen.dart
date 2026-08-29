import 'package:flutter/material.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/widgets/Borrowed%20Book%20Details/borrowed_book_header.dart';
import 'package:wayko/widgets/Borrowed%20Book%20Details/borrower_info_card.dart';
import 'package:wayko/widgets/Borrowed%20Book%20Details/borrowed_book_button.dart';
import 'package:wayko/Routes/screens_routes.dart';

class BorrowedBookDetailsScreen extends StatefulWidget {
  final BorrowModel borrow;
  const BorrowedBookDetailsScreen({super.key, required this.borrow});

  @override
  State<BorrowedBookDetailsScreen> createState() =>
      _BorrowedBookDetailsScreenState();
}

class _BorrowedBookDetailsScreenState extends State<BorrowedBookDetailsScreen> {
  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> returnBook() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Return Book"),
          content: Text("Are you sure you want to return this book?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text("Return", style: TextStyle(color: Colors.green)),
            ),
          ],
        );
      },
    );
    if (confirm != true) {
      return;
    }
    BookModel? book = BookService.getBook(widget.borrow.bookId);
    if (book == null) {
      return;
    }
    book.availableCopies++;
    await BookService.updateBook(book);
    widget.borrow.status = "returned";
    await BorrowService.updateBorrow(widget.borrow);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    BookModel? book = BookService.getBook(widget.borrow.bookId);
    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Borrowed Book Details")),
        body: Center(child: Text("Book not found")),
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text("Borrowed Book Details")),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BorrowedBookHeader(
                image: book.coverImage,
                title: book.title,
                author: book.author,
                category: book.category,
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
                borrowerName: widget.borrow.borrowerName,
                contact: widget.borrow.borrowerContact,
                borrowDate: formatDate(widget.borrow.borrowDate),
                returnDate: formatDate(widget.borrow.returnDate),
                notes: widget.borrow.notes.isEmpty
                    ? "No notes"
                    : widget.borrow.notes,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: widget.borrow.status == "active"
          ? SafeArea(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: BorrowedBookButton(
                  onReturn: () async {
                    await returnBook();
                  },
                  onEdit: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.editBorrow,
                      arguments: widget.borrow,
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
