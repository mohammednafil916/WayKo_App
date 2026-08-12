import 'package:flutter/material.dart';

class RecentlyBookCard extends StatelessWidget {
  final String image;
  final String title;
  final String category;
  const RecentlyBookCard({
    super.key,
    required this.image,
    required this.title,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 110,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
          SizedBox(height: 3),
          Text(category, style: TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}
