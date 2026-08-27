import 'package:flutter/material.dart';
import 'package:wayko/widgets/Add Book/book_copies_counter.dart';
import 'package:wayko/widgets/Add Book/book_dropdown.dart';
import 'package:wayko/widgets/Add Book/book_text_field.dart';
import 'package:wayko/widgets/Add Book/upload_cover_box.dart';
import 'package:wayko/widgets/Borrow%20Book/required_field.dart';
import 'package:wayko/widgets/bottom_button.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedFloor;
  String? selectedShelf;
  String? selectedSection;
  String? selectedRack;

  int copies = 1;

  List<String> categories = ['Fiction', 'Technology', 'History', 'Self Help'];
  List<String> floors = ['Floor 1', 'Floor 2', 'Floor 3'];
  List<String> shelves = ['Shelf 1', 'Shelf 2', 'Shelf 3'];
  List<String> sections = ['Section A', 'Section B', 'Section C'];
  List<String> racks = ['Rack 1', 'Rack 2', 'Rack 3'];
  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Book")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Basic Information",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            UploadCoverBox(onTap: () {}),
            SizedBox(height: 12),
            RequiredField(title: "Book Title"),
            SizedBox(height: 5),
            BookTextField(
              controller: titleController,
              hint: "Enter book title",
              icon: Icons.book_outlined,
            ),
            SizedBox(height: 12),
            RequiredField(title: "Author"),
            SizedBox(height: 5),
            BookTextField(
              controller: authorController,
              hint: "Enter author name",
              icon: Icons.person_outline,
            ),
            SizedBox(height: 12),
            RequiredField(title: "Category"),
            SizedBox(height: 5),
            BookDropdown(
              hint: "Select category",
              value: selectedCategory,
              items: categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              onAddNew: () {},
            ),
            SizedBox(height: 12),
            Text(
              "Description (Optional)",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            BookTextField(
              controller: descriptionController,
              hint: 'Enter description',
              icon: Icons.description_outlined,
            ),
            SizedBox(height: 12),
            RequiredField(title: "Number of Copies"),
            SizedBox(height: 5),
            BookCopiesCounter(
              value: copies,
              onMinus: () {
                if (copies > 1) {
                  setState(() {
                    copies--;
                  });
                }
              },
              onPlus: () {
                setState(() {
                  copies++;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "Book Location",
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredField(title: 'Floor'),
                      SizedBox(height: 5),
                      BookDropdown(
                        hint: "Select Floor",
                        value: selectedFloor,
                        items: floors,
                        onChanged: (value) {
                          setState(() {
                            selectedFloor = value;
                          });
                        },
                        onAddNew: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredField(title: "Rack"),
                      SizedBox(height: 5),
                      BookDropdown(
                        hint: "Select Rack",
                        value: selectedRack,
                        items: racks,
                        onChanged: (value) {
                          setState(() {
                            selectedShelf = value;
                          });
                        },
                        onAddNew: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredField(title: "Section"),
                      SizedBox(height: 5),
                      BookDropdown(
                        hint: "Select Section",
                        value: selectedSection,
                        items: sections,
                        onChanged: (value) {
                          setState(() {
                            selectedSection = value;
                          });
                        },
                        onAddNew: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RequiredField(title: "Shelf"),
                      SizedBox(height: 5),
                      BookDropdown(
                        hint: "Select Shelf",
                        value: selectedShelf,
                        items: shelves,
                        onChanged: (value) {
                          setState(() {
                            selectedRack = value;
                          });
                        },
                        onAddNew: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: BottomButton(
            onPress: () {
              Navigator.pop(context);
            },
            title: "Save Book",
          ),
        ),
      ),
    );
  }
}
