import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Providers/borrow_provider.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/widgets/Borrowed%20Book/borrowed_book_card.dart';

class BorrowedBooksScreen extends ConsumerWidget {
  const BorrowedBooksScreen({super.key});

  static const List<String> statuses = ["Current", "Returned", "Overdue"];

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borrowedBooks = ref.watch(borrowProvider);
    final books = ref.watch(bookProvider);
    final selectedStatus = ref.watch(selectedBorrowStatusProvider);
    final filteredBorrows = ref.watch(filteredBorrowsProvider);
    final loggedUserId = ref.watch(currentUserIdProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Borrowed Books"),
        actions: [
          IconButton(
            onPressed: loggedUserId == null
                ? null
                : () {
                    showSearch(
                      context: context,
                      delegate: BorrowedBookSearchDelegate(
                        borrowedBooks: borrowedBooks,
                        books: books,
                        selectedStatus: selectedStatus,
                        userId: loggedUserId,
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
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  final status = statuses[index];
                  final isSelected = selectedStatus == status;

                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        status,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : const Color.fromARGB(255, 0, 12, 143),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      showCheckmark: false,
                      selected: isSelected,
                      selectedColor: const Color.fromARGB(255, 0, 12, 143),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (value) {
                        ref
                            .read(selectedBorrowStatusProvider.notifier)
                            .setStatus(status);
                      },
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: filteredBorrows.isEmpty
                  ? Center(
                      child: Text(
                        selectedStatus == "Current"
                            ? "No current borrowed books"
                            : selectedStatus == "Returned"
                            ? "No returned books"
                            : "No overdue books",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredBorrows.length,
                      itemBuilder: (context, index) {
                        final borrow = filteredBorrows[index];

                        BookModel? book;
                        for (final item in books) {
                          if (item.id == borrow.bookId &&
                              item.userId == loggedUserId) {
                            book = item;
                            break;
                          }
                        }

                        if (book == null) {
                          return SizedBox();
                        }

                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: BorrowedBookCard(
                            borrow: borrow,
                            image: book.coverImage,
                            title: book.title,
                            author: book.author,
                            category: book.category,
                            borrower: borrow.borrowerName,
                            borrowedDate: _formatDate(borrow.borrowDate),
                            dueDate: _formatDate(borrow.returnDate),
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

class BorrowedBookSearchDelegate extends SearchDelegate<BorrowModel?> {
  final List<BorrowModel> borrowedBooks;
  final List<BookModel> books;
  final String selectedStatus;
  final String userId;

  BorrowedBookSearchDelegate({
    required this.borrowedBooks,
    required this.books,
    required this.selectedStatus,
    required this.userId,
  });

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

    List<BorrowModel> results = borrowedBooks.where((borrow) {
      if (selectedStatus == "Current") {
        if (borrow.status != "active" ||
            borrow.returnDate.isBefore(DateTime.now())) {
          return false;
        }
      }

      if (selectedStatus == "Returned") {
        if (borrow.status != "returned") {
          return false;
        }
      }

      if (selectedStatus == "Overdue") {
        if (borrow.status != "active" ||
            !borrow.returnDate.isBefore(DateTime.now())) {
          return false;
        }
      }

      BookModel? book;

      for (final item in books) {
        if (item.id == borrow.bookId && item.userId == userId) {
          book = item;
          break;
        }
      }

      if (book == null) {
        return false;
      }

      return book.title.toLowerCase().contains(searchText) ||
          book.author.toLowerCase().contains(searchText) ||
          book.category.toLowerCase().contains(searchText) ||
          borrow.borrowerName.toLowerCase().contains(searchText) ||
          borrow.borrowerContact.toLowerCase().contains(searchText);
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: Text(
          "No borrowed books found",
          style: TextStyle(color: Colors.grey, fontSize: 15),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final borrow = results[index];

        BookModel? book;

        for (final item in books) {
          if (item.id == borrow.bookId && item.userId == userId) {
            book = item;
            break;
          }
        }

        if (book == null) {
          return const SizedBox();
        }

        return Padding(
          padding: const EdgeInsets.all(5),
          child: BorrowedBookCard(
            borrow: borrow,
            image: book.coverImage,
            title: book.title,
            author: book.author,
            category: book.category,
            borrower: borrow.borrowerName,
            borrowedDate:
                "${borrow.borrowDate.day}/${borrow.borrowDate.month}/${borrow.borrowDate.year}",
            dueDate:
                "${borrow.returnDate.day}/${borrow.returnDate.month}/${borrow.returnDate.year}",
          ),
        );
      },
    );
  }
}
