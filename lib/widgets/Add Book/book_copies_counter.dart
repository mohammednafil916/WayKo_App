import 'package:flutter/material.dart';

class BookCopiesCounter extends StatelessWidget {
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const BookCopiesCounter({
    super.key,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            child: IconButton(onPressed: onMinus, icon: Icon(Icons.remove)),
          ),
          VerticalDivider(),
          Expanded(
            child: Center(
              child: Text(
                "$value",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          VerticalDivider(),
          Expanded(
            child: IconButton(onPressed: onPlus, icon: Icon(Icons.add)),
          ),
        ],
      ),
    );
  }
}
