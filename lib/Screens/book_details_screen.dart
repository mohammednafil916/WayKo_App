import 'package:flutter/material.dart';
import 'package:wayko/widgets/book_details_header.dart';
import 'package:wayko/widgets/book_location_card.dart';
import 'package:wayko/widgets/book_stats_card.dart';
import 'package:wayko/widgets/book_action_buttons.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
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
                image: "assets/images/book1.jpg",
                title: "title",
                author: "author",
                category: "category",
                isFavorite: true,
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  BookStatsCard(title: "Total Copies", value: "10"),
                  SizedBox(width: 30),
                  BookStatsCard(title: "Borrowed", value: "04"),
                  SizedBox(width: 30),
                  BookStatsCard(title: "Available", value: "06"),
                ],
              ),
              SizedBox(height: 20),
              BookLocationCard(
                floor: "floor",
                section: "section",
                rack: "rack",
                shelf: "shelf",
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
                  "A heartfelt love story about two people who find love "
                  "and dream of a beautiful future together. A touching "
                  "journey of love, loss, and memories that stay forever.",
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
          padding: EdgeInsets.all(8),
          child: BookActionButtons(
            onBorrow: () {},
            onEdit: () {},
            onDelete: () {},
          ),
        ),
      ),
    );
  }
}
