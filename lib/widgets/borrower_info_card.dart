import 'package:flutter/material.dart';

class BorrowerInfoCard extends StatelessWidget {
  final String borrowerName;
  final String contact;
  final String borrowDate;
  final String returnDate;
  final String notes;

  const BorrowerInfoCard({
    super.key,
    required this.borrowerName,
    required this.contact,
    required this.borrowDate,
    required this.returnDate,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.black),
              SizedBox(width: 12),
              Text("Borrower Name", style: TextStyle(color: Colors.black)),
              Spacer(),
              Text(borrowerName),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.black),
              SizedBox(width: 12),
              Text("Contact", style: TextStyle(color: Colors.black)),
              Spacer(),
              Text(contact),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.black),
              SizedBox(width: 12),
              Text("Borrow Date", style: TextStyle(color: Colors.black)),
              Spacer(),
              Text(borrowDate),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.calendar_month, color: Colors.black),
              SizedBox(width: 12),
              Text(
                "Expected Return Date",
                style: TextStyle(color: Colors.black),
              ),
              Spacer(),
              Text(returnDate),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.sticky_note_2_outlined, color: Colors.black),
              SizedBox(width: 12),
              Text("Notes", style: TextStyle(color: Colors.black)),
              Spacer(),
              Text(notes),
            ],
          ),
        ],
      ),
    );
  }
}
