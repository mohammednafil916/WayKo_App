import 'package:flutter/material.dart';

class ProfileAnalysisCard extends StatelessWidget {
  final int totalBooks;
  final int availableBooks;
  final int borrowedBooks;
  final int favoriteBooks;

  const ProfileAnalysisCard({
    super.key,
    required this.totalBooks,
    required this.availableBooks,
    required this.borrowedBooks,
    required this.favoriteBooks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 212, 236, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  "$totalBooks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Total Books",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Container(height: 35, width: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$availableBooks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Available",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Container(height: 35, width: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$borrowedBooks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Borrowed",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
          Container(height: 35, width: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  "$favoriteBooks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Favorites",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
