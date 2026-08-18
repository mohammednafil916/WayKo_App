import 'package:flutter/material.dart';

class BottomInfoCard extends StatelessWidget {
  const BottomInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.bar_chart_rounded, color: Colors.blue.shade900, size: 34),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Detailed reports helps you to track your "
              "library growth and activity.",
              style: TextStyle(fontSize: 12, height: 1),
            ),
          ),
        ],
      ),
    );
  }
}
