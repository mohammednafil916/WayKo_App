import 'package:flutter/material.dart';
import 'package:wayko/widgets/Borrowed%20Book/borrowed_book_card.dart';

class BorrowedBooksScreen extends StatefulWidget {
  const BorrowedBooksScreen({super.key});

  @override
  State<BorrowedBooksScreen> createState() => _BorrowedBooksScreenState();
}

class _BorrowedBooksScreenState extends State<BorrowedBooksScreen> {
  final List<String> statuses = ["Current", "Returned", "Overdue"];

  String selectedStatus = "Current";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Borrowed Books"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
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
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: BorrowedBookCard(
                      image: "assets/images/book3.jpg",
                      title: "title",
                      author: "author",
                      category: "category",
                      borrower: "borrower",
                      borrowedDate: "borrowedDate",
                      dueDate: "dueDate",
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
