import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/widgets/Book%20Details/book_details_header.dart';
import 'package:wayko/widgets/Book%20Details/book_location_card.dart';
import 'package:wayko/widgets/Book%20Details/book_stats_card.dart';
import 'package:wayko/widgets/Book%20Details/book_action_buttons.dart';
import 'package:wayko/Models/book_model.dart';

class BookDetailsScreen extends StatefulWidget {
  final BookModel book;
  const BookDetailsScreen({super.key, required this.book});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late BookModel book;
  @override
  void initState() {
    super.initState();
    book = widget.book;
  }

  Future<void> deleteBook() async {
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
    await BookService.deleteBook(book);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              BookDetailsHeader(
                image: book.coverImage,
                title: book.title,
                author: book.author,
                category: book.category,
                isFavorite: book.isFavorite,
                onFavorite: () async {
                  await BookService.toggleFavorite(book);
                  setState(() {});
                },
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  BookStatsCard(
                    title: "Total Copies",
                    value: book.copies.toString(),
                  ),
                  SizedBox(width: 30),
                  BookStatsCard(
                    title: "Borrowed",
                    value: (book.copies - book.availableCopies).toString(),
                  ),
                  SizedBox(width: 30),
                  BookStatsCard(
                    title: "Available",
                    value: book.availableCopies.toString(),
                  ),
                ],
              ),
              SizedBox(height: 20),
              BookLocationCard(
                floor: book.floor,
                section: book.section,
                rack: book.rack,
                shelf: book.shelf,
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
                  book.description.isEmpty
                      ? "No description available"
                      : book.description,
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
          padding: EdgeInsets.all(10),
          child: BookActionButtons(
            onBorrow: () {
              Navigator.pushNamed(
                context,
                AppRoutes.borrowBook,
                arguments: book,
              );
            },
            onEdit: () {
              Navigator.pushNamed(context, AppRoutes.editBook, arguments: book);
            },
            onDelete: deleteBook,
          ),
        ),
      ),
    );
  }
}
