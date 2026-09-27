import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/statistics_provider.dart';
import 'package:wayko/widgets/Home/library_overview_card.dart';
import 'package:wayko/widgets/Statistics/bottom_info_card.dart';
import 'package:wayko/widgets/Statistics/chart_percentage_data.dart';
import 'package:wayko/widgets/Statistics/circle_chart.dart';
import 'package:wayko/widgets/Statistics/statistics_small_card.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  Future<void> _selectDate(
    BuildContext context,
    WidgetRef ref, {
    required bool isFromDate,
  }) async {
    final dateRange = ref.read(statsDateRangeProvider);
    DateTime initialDate = DateTime.now();

    if (isFromDate && dateRange.fromDate != null) {
      initialDate = dateRange.fromDate!;
    }

    if (!isFromDate && dateRange.toDate != null) {
      initialDate = dateRange.toDate!;
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
      if (dateRange.toDate != null && selectedDate.isAfter(dateRange.toDate!)) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("From date cannot be after To date")),
        );
        return;
      }
      ref.read(statsDateRangeProvider.notifier).setFromDate(selectedDate);
    } else {
      if (dateRange.fromDate != null &&
          selectedDate.isBefore(dateRange.fromDate!)) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("To date cannot be before From date")),
        );
        return;
      }
      ref.read(statsDateRangeProvider.notifier).setToDate(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(detailedStatisticsProvider);
    final dateRange = ref.watch(statsDateRangeProvider);

    final fromDate = dateRange.fromDate;
    final toDate = dateRange.toDate;

    return Scaffold(
      appBar: AppBar(title: Text("Library Statistics")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _selectDate(context, ref, isFromDate: true);
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text(
                      fromDate == null
                          ? "From Date"
                          : "${fromDate.day}/${fromDate.month}/${fromDate.year}",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _selectDate(context, ref, isFromDate: false);
                    },
                    icon: Icon(Icons.calendar_month),
                    label: Text(
                      toDate == null
                          ? "To Date"
                          : "${toDate.day}/${toDate.month}/${toDate.year}",
                    ),
                  ),
                ),
                if (fromDate != null || toDate != null) ...[
                  SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      ref.read(statsDateRangeProvider.notifier).clearFilter();
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
                    value: stats.totalBooks.toString(),
                    icon: Icons.library_books,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 179, 231, 255),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Available Books",
                    value: stats.availableBooks.toString(),
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
                    value: stats.borrowedBooks.toString(),
                    icon: Icons.person,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 184, 179),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Returned Books",
                    value: stats.returnedBooks.toString(),
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
                    value: stats.overdueBooks.toString(),
                    icon: Icons.warning_amber,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 220, 179),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Favorites",
                    value: stats.favoriteBooks.toString(),
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
                  value: stats.categoriesCount.toString(),
                ),
                SizedBox(width: 8),
                StatisticsSmallCard(
                  title: "Floors",
                  value: stats.floorsCount.toString(),
                ),
                SizedBox(width: 8),
                StatisticsSmallCard(
                  title: "Racks",
                  value: stats.racksCount.toString(),
                ),
                SizedBox(width: 8),
                StatisticsSmallCard(
                  title: "Shelves",
                  value: stats.shelvesCount.toString(),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              !stats.isDateFilterActive ? "Overview" : "Borrowing Activity",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 12, 143),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                if (!stats.isDateFilterActive)
                  CircleChart(
                    available: stats.availableBooks,
                    borrowed: stats.borrowedBooks,
                    returned: stats.returnedBooks,
                    overdue: stats.overdueBooks,
                  )
                else if (stats.hasDateActivity)
                  CircleChart(
                    available: 0,
                    borrowed: stats.borrowedBooks,
                    returned: stats.returnedBooks,
                    overdue: stats.overdueBooks,
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
                      if (!stats.isDateFilterActive)
                        ChartPercentageData(
                          color: Colors.green,
                          title: "Available",
                          value: stats.availableBooks,
                          percentage: stats.availablePercentage,
                        ),
                      if (!stats.isDateFilterActive) SizedBox(height: 15),
                      ChartPercentageData(
                        color: Colors.red,
                        title: "Borrowed",
                        value: stats.borrowedBooks,
                        percentage: stats.borrowedPercentage,
                      ),
                      SizedBox(height: 15),
                      ChartPercentageData(
                        color: Colors.blue,
                        title: "Returned",
                        value: stats.returnedBooks,
                        percentage: stats.returnedPercentage,
                      ),
                      SizedBox(height: 15),
                      ChartPercentageData(
                        color: Colors.orange,
                        title: "Overdue",
                        value: stats.overdueBooks,
                        percentage: stats.overduePercentage,
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
