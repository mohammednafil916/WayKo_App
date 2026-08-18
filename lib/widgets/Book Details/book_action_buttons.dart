import 'package:flutter/material.dart';

class BookActionButtons extends StatelessWidget {
  final VoidCallback onBorrow;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookActionButtons({
    super.key,
    required this.onBorrow,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: onBorrow,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color.fromARGB(255, 0, 12, 143),
                side: BorderSide(color: Color.fromARGB(255, 0, 12, 143)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text("Borrow Book"),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: onEdit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color.fromARGB(255, 0, 12, 143),
                side: BorderSide(color: Color.fromARGB(255, 0, 12, 143)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text("Edit Book"),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text("Delete Book"),
            ),
          ),
        ),
      ],
    );
  }
}
