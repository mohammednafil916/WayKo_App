import 'package:flutter/material.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/Services/session_service.dart';
import 'package:wayko/widgets/Borrowed%20Book/borrowed_book_card.dart';

class BorrowedBooksScreen extends StatefulWidget {
  const BorrowedBooksScreen({super.key});
  @override
  State<BorrowedBooksScreen> createState() => _BorrowedBooksScreenState();
}

class _BorrowedBooksScreenState extends State<BorrowedBooksScreen> {
  final List<String> statuses = ["Current", "Returned", "Overdue"];
  String selectedStatus = "Current";
  List<BorrowModel> borrowedBooks = [];

  @override
  void initState() {
    super.initState();
    loadBorrowedBooks();
  }

  Future<void> loadBorrowedBooks() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    setState(() {
      borrowedBooks = BorrowService.getBorrows(userId);
    });
  }

  List<BorrowModel> getFilteredBorrows() {
    if (selectedStatus == "Current") {
      return borrowedBooks
          .where((borrow) => borrow.status == "active")
          .toList();
    }
    if (selectedStatus == "Returned") {
      return borrowedBooks
          .where((borrow) => borrow.status == "returned")
          .toList();
    }
    if (selectedStatus == "Overdue") {
      return borrowedBooks
          .where(
            (borrow) =>
                borrow.status == "active" &&
                borrow.returnDate.isBefore(DateTime.now()),
          )
          .toList();
    }
    return [];
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    List<BorrowModel> filteredBorrows = getFilteredBorrows();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Borrowed Books"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: BorrowedBookSearchDelegate(
                  borrowedBooks: borrowedBooks,
                  selectedStatus: selectedStatus,
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
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: statuses.length,
                itemBuilder: (context, index) {
                  final status = statuses[index];
                  final isSelected = selectedStatus == status;
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
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
                        setState(() {
                          selectedStatus = status;
                        });
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
                        BookModel? book = BookService.getBook(borrow.bookId);
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
                            borrowedDate: formatDate(borrow.borrowDate),
                            dueDate: formatDate(borrow.returnDate),
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
  final String selectedStatus;
  BorrowedBookSearchDelegate({
    required this.borrowedBooks,
    required this.selectedStatus,
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
      if (selectedStatus == "Current" && borrow.status != "active") {
        return false;
      }
      if (selectedStatus == "Returned" && borrow.status != "returned") {
        return false;
      }
      if (selectedStatus == "Overdue") {
        if (borrow.status != "active" ||
            !borrow.returnDate.isBefore(DateTime.now())) {
          return false;
        }
      }
      BookModel? book = BookService.getBook(borrow.bookId);
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
        BookModel? book = BookService.getBook(borrow.bookId);
        if (book == null) {
          return SizedBox();
        }
        return Padding(
          padding: EdgeInsets.all(5),
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
