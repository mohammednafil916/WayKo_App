import 'package:flutter/material.dart';

class WayKoAboutScreen extends StatelessWidget {
  const WayKoAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About WayKo")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(radius: 45, child: Icon(Icons.menu_book, size: 50)),

            SizedBox(height: 15),
            Text(
              "WayKo",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),
            Text(
              "Your World of Books",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            SizedBox(height: 25),
            Text(
              "About WayKo",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),
            Text(
              "WayKo is an offline library management application "
              "designed to help library owners manage their books, "
              "borrowed books, favorites, and library arrangements "
              "easily in one place.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey, height: 1.5),
            ),

            SizedBox(height: 25),
            Text(
              "Features",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),
            featureItem(Icons.library_books, "Manage Books"),
            featureItem(Icons.people, "Manage Borrowed Books"),
            featureItem(Icons.favorite, "Manage Favorite Books"),
            featureItem(Icons.bar_chart, "View Library Statistics"),
            featureItem(Icons.location_on, "Manage Library Arrangement"),
            SizedBox(height: 25),

            Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget featureItem(IconData icon, String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: Colors.grey.shade100,
      ),
    );
  }
}
