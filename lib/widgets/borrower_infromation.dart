import 'package:flutter/material.dart';
import 'package:wayko/widgets/date_input_field.dart';
import 'package:wayko/widgets/borrower_required_field.dart';

class BorrowerInfoCard extends StatefulWidget {
  const BorrowerInfoCard({super.key});

  @override
  State<BorrowerInfoCard> createState() => _BorrowerInfoCardState();
}

class _BorrowerInfoCardState extends State<BorrowerInfoCard> {
  final borrowerNameController = TextEditingController();
  final contactController = TextEditingController();
  final borrowDateController = TextEditingController();
  final returnDateController = TextEditingController();
  final notesController = TextEditingController();

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
  void dispose() {
    borrowerNameController.dispose();
    contactController.dispose();
    borrowDateController.dispose();
    returnDateController.dispose();
    notesController.dispose();
    super.dispose();
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
          BorrowerRequiredField(title: "Borrower Name"),
          SizedBox(height: 5),
          TextField(
            controller: borrowerNameController,
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
          BorrowerRequiredField(title: "Contact"),
          SizedBox(height: 5),
          TextField(
            controller: contactController,
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
          BorrowerRequiredField(title: "Borrow Date"),
          SizedBox(height: 5),
          DateInputField(
            controller: borrowDateController,
            hintText: "Enter or select borrow date",
            onTap: () {
              selectDate(borrowDateController);
            },
          ),
          SizedBox(height: 12),
          BorrowerRequiredField(title: "Expected Return Date"),
          SizedBox(height: 5),
          DateInputField(
            controller: returnDateController,
            hintText: "Enter or select return date",
            onTap: () {
              selectDate(returnDateController);
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
            controller: notesController,
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
