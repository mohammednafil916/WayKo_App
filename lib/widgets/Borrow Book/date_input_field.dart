import 'package:flutter/material.dart';

class DateInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback onTap;

  const DateInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(Icons.calendar_month_outlined),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
