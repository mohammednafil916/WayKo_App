import 'package:flutter/material.dart';

class StatisticsSmallCard extends StatelessWidget {
  final String title;
  final String value;
  const StatisticsSmallCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.lightBlueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: TextStyle(fontSize: 12, color: Colors.black)),
            SizedBox(height: 3),
            Text(title, style: TextStyle(fontSize: 8, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
