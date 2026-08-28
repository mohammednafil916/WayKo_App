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
    final String? validValue = value != null && items.contains(value)
        ? value
        : null;
    return Container(
      height: 35,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: validValue,
          isExpanded: true,
          hint: Text(
            hint,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.blue.shade900),
          items: [
            ...items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 11)),
              );
            }),
            DropdownMenuItem<String>(
              value: "ADD_NEW",
              child: Text(
                "+ Add New",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onChanged: (selectedValue) {
            if (selectedValue == "ADD_NEW") {
              onAddNew();
            } else {
              onChanged(selectedValue);
            }
          },
        ),
      ),
    );
  }
}
