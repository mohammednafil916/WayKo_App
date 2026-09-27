import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Providers/borrow_provider.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/widgets/Borrowed%20Book%20Details/borrowed_book_button.dart';
import 'package:wayko/widgets/Borrowed%20Book%20Details/borrowed_book_header.dart';
import 'package:wayko/widgets/Borrowed%20Book%20Details/borrower_info_card.dart';

class BorrowedBookDetailsScreen extends ConsumerWidget {
  final BorrowModel borrow;

  const BorrowedBookDetailsScreen({super.key, required this.borrow});

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _returnBook(
    BuildContext context,
    WidgetRef ref,
    BorrowModel currentBorrow,
  ) async {
    if (currentBorrow.status != "active") {
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

    final books = ref.read(bookProvider);
    BookModel? book;
    for (final item in books) {
      if (item.id == currentBorrow.bookId) {
        book = item;
        break;
      }
    }

    if (book == null) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Book not found")));
      return;
    }

    if (book.availableCopies < book.copies) {
      book.availableCopies++;
      await ref.read(bookProvider.notifier).updateBook(book);
    }

    await ref.read(borrowProvider.notifier).returnBook(currentBorrow);

    if (!context.mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borrows = ref.watch(borrowProvider);
    final books = ref.watch(bookProvider);

    BorrowModel currentBorrow = borrow;
    for (final b in borrows) {
      if (b.id == borrow.id) {
        currentBorrow = b;
        break;
      }
    }

    BookModel? book;
    for (final item in books) {
      if (item.id == currentBorrow.bookId) {
        book = item;
        break;
      }
    }

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
                borrowerName: currentBorrow.borrowerName,
                contact: currentBorrow.borrowerContact,
                borrowDate: _formatDate(currentBorrow.borrowDate),
                returnDate: _formatDate(currentBorrow.returnDate),
                notes: currentBorrow.notes.isEmpty
                    ? "No notes"
                    : currentBorrow.notes,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: currentBorrow.status == "active"
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BorrowedBookButton(
                  onReturn: () => _returnBook(context, ref, currentBorrow),
                  onEdit: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.editBorrow,
                      arguments: currentBorrow,
                    );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
