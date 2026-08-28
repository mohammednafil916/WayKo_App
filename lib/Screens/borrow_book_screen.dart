import 'package:flutter/material.dart';
import 'package:wayko/widgets/Borrow%20Book/borrow_book_header.dart';
import 'package:wayko/widgets/Borrow%20Book/borrower_infromation.dart';
import 'package:wayko/widgets/bottom_button.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/Services/session_service.dart';

class BorrowBookScreen extends StatefulWidget {
  final BookModel book;
  const BorrowBookScreen({super.key, required this.book});

  @override
  State<BorrowBookScreen> createState() => _BorrowBookScreenState();
}

class _BorrowBookScreenState extends State<BorrowBookScreen> {
  final borrowerNameController = TextEditingController();
  final contactController = TextEditingController();
  final borrowDateController = TextEditingController();
  final returnDateController = TextEditingController();
  final notesController = TextEditingController();

  DateTime convertDate(String date) {
    List<String> parts = date.split("/");
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  Future<void> confirmBorrow() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    if (borrowerNameController.text.trim().isEmpty ||
        contactController.text.trim().isEmpty ||
        borrowDateController.text.trim().isEmpty ||
        returnDateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }
    if (widget.book.availableCopies <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No copies available for borrowing")),
      );
      return;
    }
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Borrow"),
          content: Text(
            "Are you sure you want to borrow "
            "\"${widget.book.title}\" for "
            "${borrowerNameController.text.trim()}?",
          ),
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
              child: Text("Confirm", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
    if (confirm != true) {
      return;
    }
    DateTime borrowDate = convertDate(borrowDateController.text);
    DateTime returnDate = convertDate(returnDateController.text);

    BorrowModel borrow = BorrowModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      userId: userId,
      bookId: widget.book.id,
      borrowerName: borrowerNameController.text.trim(),
      borrowerContact: contactController.text.trim(),
      borrowDate: borrowDate,
      returnDate: returnDate,
      status: "active",
      notes: notesController.text.trim(),
    );

    await BorrowService.addBorrow(borrow);
    widget.book.availableCopies--;
    await BookService.updateBook(widget.book);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    borrowerNameController.dispose();
    contactController.dispose();
    borrowDateController.dispose();
    returnDateController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Borrow Book")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BorrowBookHeader(
              image: widget.book.coverImage,
              title: widget.book.title,
              author: widget.book.author,
              category: widget.book.category,
              copiesCount: widget.book.availableCopies.toString(),
            ),
            SizedBox(height: 15),
            Text(
              "Borrower Infrormation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 10),
            BorrowerInfoCard(
              borrowerNameController: borrowerNameController,
              contactController: contactController,
              borrowDateController: borrowDateController,
              returnDateController: returnDateController,
              notesController: notesController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: BottomButton(
            onPress: confirmBorrow,
            title: "Confirm Borrow",
            icon: Icons.add_home_sharp,
          ),
        ),
      ),
    );
  }
}
