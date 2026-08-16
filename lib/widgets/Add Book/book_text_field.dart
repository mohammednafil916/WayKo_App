import 'package:flutter/material.dart';

class BookTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  const BookTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey),contentPadding: EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Icon(icon, size: 18, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
