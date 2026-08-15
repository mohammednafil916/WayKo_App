import 'package:flutter/material.dart';

class BorrowedBookButton extends StatelessWidget {
  final VoidCallback onReturn;
  final VoidCallback onEdit;

  const BorrowedBookButton({
    super.key,
    required this.onReturn,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: onReturn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Mark as Returned"),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: onEdit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Edit Borrow Info"),
            ),
          ),
        ),
      ],
    );
  }
}
