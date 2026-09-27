import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Providers/add_book_provider.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Routes/screens_routes.dart';
import 'package:wayko/widgets/Book/book_card.dart';

class BookScreen extends ConsumerWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookProvider);
    final filteredBooks = ref.watch(filteredBooksProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final arrangement = ref.watch(addBookProvider);

    final categories = ["All", ...arrangement.categories];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Books"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate(books));
            },
            icon: Icon(Icons.search),
          ),
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
                        ref
                            .read(selectedCategoryProvider.notifier)
                            .setCategory(category);
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
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addBook);
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
