import 'package:flutter/material.dart';

class BorrowerRequiredField extends StatelessWidget {
  final String title;

  const BorrowerRequiredField({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: " *",
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
