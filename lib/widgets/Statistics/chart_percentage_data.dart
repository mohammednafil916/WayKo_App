import 'package:flutter/material.dart';

class ChartPercentageData extends StatelessWidget {
  final Color color;
  final String title;
  final int value;
  final double percentage;
  const ChartPercentageData({
    super.key,
    required this.color,
    required this.title,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 15),
        Text(
          "$value (${percentage.round()}%)",
          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
