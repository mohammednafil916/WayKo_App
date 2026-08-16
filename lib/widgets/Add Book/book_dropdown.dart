import 'package:flutter/material.dart';

class BookDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final VoidCallback onAddNew;

  const BookDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: TextStyle(fontSize: 11, color: Colors.grey)),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade900),
          items: [
            ...items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item, style: TextStyle(fontSize: 11)),
              );
            }),

            DropdownMenuItem(
              value: "ADD_NEW",
              child: Text(
                "+ Add New",
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (value) {
            if (value == "ADD_NEW") {
              onAddNew();
            } else {
              onChanged(value);
            }
          },
        ),
      ),
    );
  }
}
