import 'package:flutter/material.dart';
import 'package:wayko/widgets/Home/library_overview_card.dart';
import 'package:wayko/widgets/Statistics/statistics_small_card.dart';
import 'package:wayko/widgets/Statistics/circle_chart.dart';
import 'package:wayko/widgets/Statistics/chart_percentage_data.dart';
import 'package:wayko/widgets/Statistics/bottom_info_card.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/Services/session_service.dart';
import 'package:wayko/Models/library_arrangement_model.dart';
import 'package:wayko/Services/library_arrangement_service.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int totalBooks = 0;
  int availableBooks = 0;
  int borrowedBooks = 0;
  int returnedBooks = 0;
  int overdueBooks = 0;
  int favoriteBooks = 0;
  int categoriesCount = 0;
  int floorsCount = 0;
  int racksCount = 0;
  int shelvesCount = 0;

  DateTime? fromDate;
  DateTime? toDate;
  List<BorrowModel> allBorrows = [];

  double get availablePercentage {
    if (totalBooks == 0) {
      return 0;
    }
    return availableBooks / totalBooks * 100;
  }

  double get borrowedPercentage {
    if (isDateFilterActive) {
      int totalActivity = borrowedBooks + returnedBooks + overdueBooks;
      if (totalActivity == 0) {
        return 0;
      }
      return borrowedBooks / totalActivity * 100;
    }
    if (totalBooks == 0) {
      return 0;
    }
    return borrowedBooks / totalBooks * 100;
  }

  bool get isDateFilterActive {
    return fromDate != null && toDate != null;
  }

  bool get hasDateActivity {
    return borrowedBooks > 0 || returnedBooks > 0 || overdueBooks > 0;
  }

  double get returnedPercentage {
    int totalActivity = borrowedBooks + returnedBooks + overdueBooks;
    if (totalActivity == 0) {
      return 0;
    }
    return returnedBooks / totalActivity * 100;
  }

  double get overduePercentage {
    int totalActivity = borrowedBooks + returnedBooks + overdueBooks;
    if (totalActivity == 0) {
      return 0;
    }
    return overdueBooks / totalActivity * 100;
  }

  Future<void> loadStatistics() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    List<BookModel> books = BookService.getBooks(userId);
    allBorrows = BorrowService.getBorrows(userId);
    LibraryArrangementModel? arrangement =
        LibraryArrangementService.getArrangement(userId);
    setState(() {
      totalBooks = books.fold(0, (sum, book) => sum + book.copies);
      availableBooks = books.fold(0, (sum, book) => sum + book.availableCopies);
      borrowedBooks = allBorrows
          .where(
            (borrow) =>
                borrow.status == "active" &&
                !borrow.returnDate.isBefore(DateTime.now()) &&
                isBorrowInSelectedRange(borrow),
          )
          .length;
      returnedBooks = allBorrows
          .where(
            (borrow) =>
                borrow.status == "returned" &&
                isReturnedInSelectedRange(borrow),
          )
          .length;
      overdueBooks = allBorrows
          .where(
            (borrow) =>
                borrow.status == "active" &&
                borrow.returnDate.isBefore(DateTime.now()) &&
                isBorrowInSelectedRange(borrow),
          )
          .length;
      favoriteBooks = books.where((book) => book.isFavorite).length;
      categoriesCount = arrangement?.categories.length ?? 0;
      floorsCount = arrangement?.floors.length ?? 0;
      racksCount = arrangement?.racks.length ?? 0;
      shelvesCount = arrangement?.shelves.length ?? 0;
    });
  }

  Future<void> selectDate({required bool isFromDate}) async {
    DateTime initialDate = DateTime.now();
    if (isFromDate && fromDate != null) {
      initialDate = fromDate!;
    }
    if (!isFromDate && toDate != null) {
      initialDate = toDate!;
    }
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (selectedDate == null) {
      return;
    }
    if (isFromDate) {
      if (toDate != null && selectedDate.isAfter(toDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("From date cannot be after To date")),
        );
        return;
      }
      fromDate = selectedDate;
    } else {
      if (fromDate != null && selectedDate.isBefore(fromDate!)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("To date cannot be before From date")),
        );
        return;
      }
      toDate = selectedDate;
    }
    await loadStatistics();
  }

  bool isBorrowInSelectedRange(BorrowModel borrow) {
    if (fromDate == null || toDate == null) {
      return true;
    }
    DateTime borrowDate = DateTime(
      borrow.borrowDate.year,
      borrow.borrowDate.month,
      borrow.borrowDate.day,
    );
    DateTime startDate = DateTime(
      fromDate!.year,
      fromDate!.month,
      fromDate!.day,
    );
    DateTime endDate = DateTime(toDate!.year, toDate!.month, toDate!.day);
    return !borrowDate.isBefore(startDate) && !borrowDate.isAfter(endDate);
  }

  bool isReturnedInSelectedRange(BorrowModel borrow) {
    if (borrow.actualReturnDate == null) {
      return false;
    }
    if (fromDate == null || toDate == null) {
      return true;
    }
    DateTime returnedDate = DateTime(
      borrow.actualReturnDate!.year,
      borrow.actualReturnDate!.month,
      borrow.actualReturnDate!.day,
    );
    DateTime startDate = DateTime(
      fromDate!.year,
      fromDate!.month,
      fromDate!.day,
    );
    DateTime endDate = DateTime(toDate!.year, toDate!.month, toDate!.day);
    return !returnedDate.isBefore(startDate) && !returnedDate.isAfter(endDate);
  }

  @override
  void initState() {
    super.initState();
    loadStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Library Statistics")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      selectDate(isFromDate: true);
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text(
                      fromDate == null
                          ? "From Date"
                          : "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      selectDate(isFromDate: false);
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text(
                      toDate == null
                          ? "To Date"
                          : "${toDate!.day}/${toDate!.month}/${toDate!.year}",
                    ),
                  ),
                ),
                if (fromDate != null || toDate != null) ...[
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        fromDate = null;
                        toDate = null;
                      });
                      await loadStatistics();
                    },
                    icon: Icon(Icons.clear),
                    tooltip: "Clear filter",
                  ),
                ],
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Total Books",
                    value: totalBooks.toString(),
                    icon: Icons.library_books,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 179, 231, 255),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Available Books",
                    value: availableBooks.toString(),
                    icon: Icons.book,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 213, 245, 177),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Borrowed Books",
                    value: borrowedBooks.toString(),
                    icon: Icons.person,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 184, 179),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Returned Books",
                    value: returnedBooks.toString(),
                    icon: Icons.assignment_return,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 195, 237),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Overdue Books",
                    value: overdueBooks.toString(),
                    icon: Icons.warning_amber,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 220, 179),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Favorites",
                    value: favoriteBooks.toString(),
                    icon: Icons.star_border,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 179, 231, 255),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatisticsSmallCard(
                  title: "Categories",
                  value: categoriesCount.toString(),
                ),
                SizedBox(width: 8),
                StatisticsSmallCard(
                  title: "Floors",
                  value: floorsCount.toString(),
                ),
                SizedBox(width: 8),
                StatisticsSmallCard(
                  title: "Racks",
                  value: racksCount.toString(),
                ),
                SizedBox(width: 8),
                StatisticsSmallCard(
                  title: "Shelves",
                  value: shelvesCount.toString(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              fromDate == null && toDate == null
                  ? "Overview"
                  : "Borrowing Activity",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 12, 143),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                if (!isDateFilterActive)
                  CircleChart(
                    available: availableBooks,
                    borrowed: borrowedBooks,
                    returned: returnedBooks,
                    overdue: overdueBooks,
                  )
                else if (hasDateActivity)
                  CircleChart(
                    available: 0,
                    borrowed: borrowedBooks,
                    returned: returnedBooks,
                    overdue: overdueBooks,
                  )
                else
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: Center(
                      child: Text(
                        "No borrowing activity\nfor selected dates",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (!isDateFilterActive)
                        ChartPercentageData(
                          color: Colors.green,
                          title: "Available",
                          value: availableBooks,
                          percentage: availablePercentage,
                        ),
                      if (!isDateFilterActive) SizedBox(height: 15),
                      ChartPercentageData(
                        color: Colors.red,
                        title: "Borrowed",
                        value: borrowedBooks,
                        percentage: borrowedPercentage,
                      ),
                      SizedBox(height: 15),
                      ChartPercentageData(
                        color: Colors.blue,
                        title: "Returned",
                        value: returnedBooks,
                        percentage: returnedPercentage,
                      ),
                      SizedBox(height: 15),
                      ChartPercentageData(
                        color: Colors.orange,
                        title: "Overdue",
                        value: overdueBooks,
                        percentage: overduePercentage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            BottomInfoCard(),
          ],
        ),
      ),
    );
  }
}
