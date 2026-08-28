import 'package:flutter/material.dart';
import 'package:wayko/widgets/Borrow%20Book/date_input_field.dart';
import 'package:wayko/widgets/Borrow%20Book/required_field.dart';

class BorrowerInfoCard extends StatefulWidget {
  final TextEditingController borrowerNameController;
  final TextEditingController contactController;
  final TextEditingController borrowDateController;
  final TextEditingController returnDateController;
  final TextEditingController notesController;

  const BorrowerInfoCard({
    super.key,
    required this.borrowerNameController,
    required this.contactController,
    required this.borrowDateController,
    required this.returnDateController,
    required this.notesController,
  });

  @override
  State<BorrowerInfoCard> createState() => _BorrowerInfoCardState();
}

class _BorrowerInfoCardState extends State<BorrowerInfoCard> {
  Future<void> selectDate(TextEditingController controller) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (date != null) {
      controller.text = '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequiredField(title: "Borrower Name"),
          SizedBox(height: 5),
          TextField(
            controller: widget.borrowerNameController,
            decoration: InputDecoration(
              hintText: "Enter borrower name",
              hintStyle: TextStyle(fontSize: 14),
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 12),
          RequiredField(title: "Contact"),
          SizedBox(height: 5),
          TextField(
            controller: widget.contactController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "Enter contact number",
              hintStyle: TextStyle(fontSize: 14),
              prefixIcon: Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 12),
          RequiredField(title: "Borrow Date"),
          SizedBox(height: 5),
          DateInputField(
            controller: widget.borrowDateController,
            hintText: "Enter or select borrow date",
            onTap: () {
              selectDate(widget.borrowDateController);
            },
          ),
          SizedBox(height: 12),
          RequiredField(title: "Expected Return Date"),
          SizedBox(height: 5),
          DateInputField(
            controller: widget.returnDateController,
            hintText: "Enter or select return date",
            onTap: () {
              selectDate(widget.returnDateController);
            },
          ),
          SizedBox(height: 12),
          Text(
            "Notes (Optional)",
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5),
          TextField(
            controller: widget.notesController,
            decoration: InputDecoration(
              hintText: "Enter notes (if any)",
              hintStyle: TextStyle(fontSize: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
