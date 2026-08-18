import 'package:flutter/material.dart';
import 'package:wayko/widgets/Borrow%20Book/borrow_book_header.dart';
import 'package:wayko/widgets/Borrow%20Book/borrower_infromation.dart';
import 'package:wayko/widgets/bottom_button.dart';

class BorrowBookScreen extends StatefulWidget {
  const BorrowBookScreen({super.key});

  @override
  State<BorrowBookScreen> createState() => _BorrowBookScreenState();
}

class _BorrowBookScreenState extends State<BorrowBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Borrow Book")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BorrowBookHeader(
              image: "assets/images/book2.jpg",
              title: "title",
              author: "author",
              category: "category",
              copiesCount: "20",
            ),
            SizedBox(height: 15),
            Text(
              "Borrower Infrormation",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 10),
            BorrowerInfoCard(),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: BottomButton(
            onPress: () {},
            title: "Confirm Borrow",
            icon: Icons.add_home_sharp,
          ),
        ),
      ),
    );
  }
}
