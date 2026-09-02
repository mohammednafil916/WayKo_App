import 'package:flutter/material.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/Services/session_service.dart';
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
  String? loggedUserId;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    String? userId = await SessionService.getLoggedUserId();

    if (!mounted) return;

    setState(() {
      loggedUserId = userId;
    });
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> returnBook() async {
    if (loggedUserId == null) {
      return;
    }

    if (widget.borrow.status != "active") {
      return;
    }

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

    BookModel? book = BookService.getBook(widget.borrow.bookId, loggedUserId!);

    if (book == null) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Book not found")));

      return;
    }

    if (book.availableCopies < book.copies) {
      book.availableCopies++;

      await BookService.updateBook(book);
    }

    await BorrowService.returnBook(widget.borrow);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Future<void> openEditBorrow() async {
    await Navigator.pushNamed(
      context,
      AppRoutes.editBorrow,
      arguments: widget.borrow,
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loggedUserId == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    BookModel? book = BookService.getBook(widget.borrow.bookId, loggedUserId!);

    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Borrowed Book Details")),
        body: Center(child: Text("Book not found")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Borrowed Book Details")),

      body: Padding(
        padding: const EdgeInsets.all(10),
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
                padding: const EdgeInsets.all(10),
                child: BorrowedBookButton(
                  onReturn: returnBook,
                  onEdit: openEditBorrow,
                ),
              ),
            )
          : null,
    );
  }
}
