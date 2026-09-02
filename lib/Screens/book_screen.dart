import 'package:flutter/material.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/widgets/Book/book_card.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Services/session_service.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/library_arrangement_service.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({super.key});

  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  List<String> categories = ["All"];
  String selectedCategory = "All";

  List<BookModel> books = [];

  List<BookModel> get filteredBooks {
    if (selectedCategory == "All") {
      return books;
    }

    return books.where((book) => book.category == selectedCategory).toList();
  }

  @override
  void initState() {
    super.initState();
    refreshBooks();
  }

  Future<void> refreshBooks() async {
    await loadBooks();
    await loadCategories();
  }

  Future<void> loadBooks() async {
    String? userId = await SessionService.getLoggedUserId();

    if (userId == null) {
      return;
    }

    List<BookModel> loadedBooks = BookService.getBooks(userId);

    if (!mounted) return;

    setState(() {
      books = loadedBooks;
    });
  }

  Future<void> loadCategories() async {
    String? userId = await SessionService.getLoggedUserId();

    if (userId == null) {
      return;
    }

    List<String> hiveCategories = LibraryArrangementService.getCategories(
      userId,
    );

    if (!mounted) return;

    setState(() {
      categories = ["All", ...hiveCategories];

      if (!categories.contains(selectedCategory)) {
        selectedCategory = "All";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Books"),
        actions: [
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: BookSearchDelegate(books),
              );

              await refreshBooks();
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
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

            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "${filteredBooks.length} Books",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 12, 143),
                ),
              ),
            ),

            SizedBox(height: 8),

            Expanded(
              child: filteredBooks.isEmpty
                  ? Center(
                      child: Text(
                        selectedCategory == "All"
                            ? "No books available"
                            : "No books in this category",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredBooks.length,
                      itemBuilder: (context, index) {
                        final book = filteredBooks[index];

                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: BookCard(book: book),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.lightBlue,
        onPressed: () async {
          await Navigator.pushNamed(context, AppRoutes.addBook);

          await refreshBooks();
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate<BookModel?> {
  final List<BookModel> books;

  BookSearchDelegate(this.books);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildSearchResults();
  }

  Widget buildSearchResults() {
    String searchText = query.trim().toLowerCase();

    if (searchText.isEmpty) {
      return SizedBox();
    }

    List<BookModel> results = books.where((book) {
      return book.title.toLowerCase().contains(searchText) ||
          book.author.toLowerCase().contains(searchText) ||
          book.category.toLowerCase().contains(searchText);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          "No books found",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final book = results[index];

        return Padding(
          padding: const EdgeInsets.all(5),
          child: BookCard(book: book),
        );
      },
    );
  }
}
