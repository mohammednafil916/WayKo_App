import 'package:flutter/material.dart';
import 'package:wayko/widgets/Home/library_overview_card.dart';
import 'package:wayko/widgets/Statistics/statistics_small_card.dart';
import 'package:wayko/widgets/Statistics/circle_chart.dart';
import 'package:wayko/widgets/Statistics/chart_percentage_data.dart';
import 'package:wayko/widgets/Statistics/bottom_info_card.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final int totalBooks = 1250;
  final int availableBooks = 1100;
  final int borrowedBooks = 150;

  String selectedMonth = "August";
  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  double get availablePercentage {
    return availableBooks / totalBooks * 100;
  }

  double get borrowedPercentage {
    return borrowedBooks / totalBooks * 100;
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
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 38,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(9),
                ),
                child: DropdownButton<String>(
                  value: selectedMonth,
                  underline: SizedBox(),
                  icon: Icon(Icons.keyboard_arrow_down, size: 18),
                  items: months.map((month) {
                    return DropdownMenuItem(value: month, child: Text(month));
                  }).toList(),
                  onChanged: (month) {
                    if (month == null) {
                      return;
                    }
                    setState(() {
                      selectedMonth = month;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Total Books",
                    value: "1,250",
                    icon: Icons.library_books,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 179, 231, 255),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Available Books",
                    value: "1,100 ",
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
                    value: "150",
                    icon: Icons.person,
                    iconColor: Colors.black,
                    color: const Color.fromARGB(255, 255, 184, 179),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: LibraryOverviewCard(
                    title: "Favorites",
                    value: "150",
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
                StatisticsSmallCard(title: "Categories", value: "12"),
                SizedBox(width: 8),
                StatisticsSmallCard(title: "Floors", value: "4"),
                SizedBox(width: 8),
                StatisticsSmallCard(title: "Racks", value: "38"),
                SizedBox(width: 8),
                StatisticsSmallCard(title: "Shelves", value: "9"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Overview",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 12, 143),
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                CircleChart(available: availableBooks, borrowed: borrowedBooks),
                Expanded(
                  child: Column(
                    children: [
                      ChartPercentageData(
                        color: Colors.green,
                        title: "Available",
                        value: availableBooks,
                        percentage: availablePercentage,
                      ),
                      SizedBox(height: 20),
                      ChartPercentageData(
                        color: Colors.red,
                        title: "Borrowed",
                        value: borrowedBooks,
                        percentage: borrowedPercentage,
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
