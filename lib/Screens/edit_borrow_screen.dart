import 'package:flutter/material.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/Services/session_service.dart';
import 'package:wayko/widgets/Borrow%20Book/borrow_book_header.dart';
import 'package:wayko/widgets/Borrow%20Book/borrower_infromation.dart';
import 'package:wayko/widgets/bottom_button.dart';

class EditBorrowScreen extends StatefulWidget {
  final BorrowModel borrow;

  const EditBorrowScreen({super.key, required this.borrow});

  @override
  State<EditBorrowScreen> createState() => _EditBorrowScreenState();
}

class _EditBorrowScreenState extends State<EditBorrowScreen> {
  late TextEditingController borrowerNameController;
  late TextEditingController contactController;
  late TextEditingController borrowDateController;
  late TextEditingController returnDateController;
  late TextEditingController notesController;

  @override
  void initState() {
    super.initState();

    borrowerNameController = TextEditingController(
      text: widget.borrow.borrowerName,
    );

    contactController = TextEditingController(
      text: widget.borrow.borrowerContact,
    );

    borrowDateController = TextEditingController(
      text: formatDate(widget.borrow.borrowDate),
    );

    returnDateController = TextEditingController(
      text: formatDate(widget.borrow.returnDate),
    );

    notesController = TextEditingController(text: widget.borrow.notes);
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  DateTime convertDate(String date) {
    List<String> parts = date.split("/");

    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  Future<void> updateBorrow() async {
    if (borrowerNameController.text.trim().isEmpty ||
        contactController.text.trim().isEmpty ||
        borrowDateController.text.trim().isEmpty ||
        returnDateController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    DateTime borrowDate = convertDate(borrowDateController.text);

    DateTime returnDate = convertDate(returnDateController.text);

    if (returnDate.isBefore(borrowDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Return date cannot be before borrow date")),
      );
      return;
    }

    widget.borrow.borrowerName = borrowerNameController.text.trim();

    widget.borrow.borrowerContact = contactController.text.trim();

    widget.borrow.borrowDate = borrowDate;

    widget.borrow.returnDate = returnDate;

    widget.borrow.notes = notesController.text.trim();

    await BorrowService.updateBorrow(widget.borrow);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Borrow details updated successfully")),
    );

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
    return FutureBuilder<String?>(
      future: SessionService.getLoggedUserId(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text("Edit Borrow")),
            body: Center(child: CircularProgressIndicator()),
          );
        }

        String userId = snapshot.data!;

        BookModel? book = BookService.getBook(widget.borrow.bookId, userId);

        if (book == null) {
          return Scaffold(
            appBar: AppBar(title: Text("Edit Borrow")),
            body: Center(child: Text("Book not found")),
          );
        }

        return Scaffold(
          appBar: AppBar(title: Text("Edit Borrow")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BorrowBookHeader(
                  image: book.coverImage,
                  title: book.title,
                  author: book.author,
                  category: book.category,
                  copiesCount: book.availableCopies.toString(),
                ),

                SizedBox(height: 15),

                Text(
                  "Borrower Information",
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
                onPress: updateBorrow,
                title: "Update Borrow",
                icon: Icons.save,
              ),
            ),
          ),
        );
      },
    );
  }
}
