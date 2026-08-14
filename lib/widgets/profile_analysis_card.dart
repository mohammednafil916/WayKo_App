import 'package:flutter/material.dart';

class ProfileAnalysisCard extends StatelessWidget {
  const ProfileAnalysisCard({super.key});

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
                  "1,250",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text("Total Books", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Container(height: 35, width: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  "1,100",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text("Available", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Container(height: 35, width: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  "150",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text("Borrowed", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Container(height: 35, width: 1, color: Colors.grey),
          Expanded(
            child: Column(
              children: [
                Text(
                  "08",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 3),
                Text("Favorites", style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
