import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/widgets/Book%20Details/book_action_buttons.dart';
import 'package:wayko/widgets/Book%20Details/book_details_header.dart';
import 'package:wayko/widgets/Book%20Details/book_location_card.dart';
import 'package:wayko/widgets/Book%20Details/book_stats_card.dart';

class BookDetailsScreen extends ConsumerWidget {
  final BookModel book;

  const BookDetailsScreen({super.key, required this.book});

  Future<void> deleteBook(
    BuildContext context,
    WidgetRef ref,
    BookModel currentBook,
  ) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete Book"),
          content: Text("Are you sure you want to delete this book?"),
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
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirm != true) {
      return;
    }

    await ref.read(bookProvider.notifier).deleteBook(currentBook);

    if (!context.mounted) return;

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookProvider);
    BookModel currentBook = book;

    for (final item in books) {
      if (item.id == book.id) {
        currentBook = item;
        break;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Book Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              BookDetailsHeader(
                image: currentBook.coverImage,
                title: currentBook.title,
                author: currentBook.author,
                category: currentBook.category,
                isFavorite: currentBook.isFavorite,
                onFavorite: () {
                  ref.read(bookProvider.notifier).toggleFavorite(currentBook);
                },
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  BookStatsCard(
                    title: "Total Copies",
                    value: currentBook.copies.toString(),
                  ),
                  SizedBox(width: 30),
                  BookStatsCard(
                    title: "Borrowed",
                    value: (currentBook.copies - currentBook.availableCopies)
                        .toString(),
                  ),
                  SizedBox(width: 30),
                  BookStatsCard(
                    title: "Available",
                    value: currentBook.availableCopies.toString(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              BookLocationCard(
                floor: currentBook.floor,
                section: currentBook.section,
                rack: currentBook.rack,
                shelf: currentBook.shelf,
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About the Book",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  currentBook.description.isEmpty
                      ? "No description available"
                      : currentBook.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    height: 1.5,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    "Read more",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BookActionButtons(
            onBorrow: () {
              Navigator.pushNamed(
                context,
                AppRoutes.borrowBook,
                arguments: currentBook,
              );
            },
            onEdit: () {
              Navigator.pushNamed(
                context,
                AppRoutes.editBook,
                arguments: currentBook,
              );
            },
            onDelete: () {
              deleteBook(context, ref, currentBook);
            },
          ),
        ),
      ),
    );
  }
}
