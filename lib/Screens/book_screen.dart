import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/Screens/book_details_screen.dart';
import 'package:wayko/widgets/book_card.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  void bookDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailsScreen()),
    );
  }

  final List<String> categories = [
    "All",
    "Science",
    "Technology",
    "Fiction",
    "History",
  ];

  String selectedCategory = "All";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Books"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.addBook);
            },
            icon: Icon(Icons.add_box),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color.fromARGB(255, 0, 12, 143),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      showCheckmark: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      selected: isSelected,
                      selectedColor: const Color.fromARGB(255, 0, 12, 143),
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1,250 Books",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 12, 143),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt_outlined),
                  label: Text("Filter"),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  BookCard(
                    image: "assets/images/book1.jpg",
                    title: "title",
                    author: "author",
                    category: "category",
                    available: "20",
                    onClick: bookDetails,
                  ),
                  SizedBox(height: 10),
                  BookCard(
                    image: "assets/images/book1.jpg",
                    title: "title",
                    author: "author",
                    category: "category",
                    available: "20",
                    onClick: bookDetails,
                  ),
                  SizedBox(height: 10),
                  BookCard(
                    image: "assets/images/book1.jpg",
                    title: "title",
                    author: "author",
                    category: "category",
                    available: "20",
                    onClick: bookDetails,
                  ),
                  SizedBox(height: 10),
                  BookCard(
                    image: "assets/images/book1.jpg",
                    title: "title",
                    author: "author",
                    category: "category",
                    available: "20",
                    onClick: bookDetails,
                  ),
                  SizedBox(height: 10),
                  BookCard(
                    image: "assets/images/book1.jpg",
                    title: "title",
                    author: "author",
                    category: "category",
                    available: "20",
                    onClick: bookDetails,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
