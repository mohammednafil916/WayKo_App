import 'package:flutter/material.dart';

class BorrowButton extends StatelessWidget {
  final VoidCallback onPress;
  const BorrowButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 12, 143),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.post_add),
            SizedBox(width: 3),
            Text(
              "Confirm Borrow",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
