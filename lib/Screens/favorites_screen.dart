import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/widgets/Favorite/favorite_book_card.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteBooks = ref.watch(favoriteBooksProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Favorites Books"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: FavoriteBookSearchDelegate(
                  favoriteBooks: favoriteBooks,
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Books you have marked as favorites",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 134, 200, 255),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "${favoriteBooks.length} Books",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: favoriteBooks.isEmpty
                  ? Center(
                      child: Text(
                        "No favorite books",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoriteBooks.length,
                      itemBuilder: (context, index) {
                        BookModel book = favoriteBooks[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: FavoriteBookCard(
                            book: book,
                            image: book.coverImage,
                            title: book.title,
                            author: book.author,
                            category: book.category,
                            floor: book.floor,
                            section: book.section,
                            shelf: book.shelf,
                            copies: book.copies.toString(),
                            available: book.availableCopies.toString(),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoriteBookSearchDelegate extends SearchDelegate<BookModel?> {
  final List<BookModel> favoriteBooks;

  FavoriteBookSearchDelegate({required this.favoriteBooks});

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

    List<BookModel> results = favoriteBooks.where((book) {
      return book.title.toLowerCase().contains(searchText) ||
          book.author.toLowerCase().contains(searchText) ||
          book.category.toLowerCase().contains(searchText);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          "No favorite books found",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        BookModel book = results[index];

        return Padding(
          padding: const EdgeInsets.all(5),
          child: FavoriteBookCard(
            book: book,
            image: book.coverImage,
            title: book.title,
            author: book.author,
            category: book.category,
            floor: book.floor,
            section: book.section,
            shelf: book.shelf,
            copies: book.copies.toString(),
            available: book.availableCopies.toString(),
          ),
        );
      },
    );
  }
}
