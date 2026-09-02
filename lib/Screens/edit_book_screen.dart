import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayko/widgets/Add Book/book_copies_counter.dart';
import 'package:wayko/widgets/Add Book/book_dropdown.dart';
import 'package:wayko/widgets/Add Book/book_text_field.dart';
import 'package:wayko/widgets/Add Book/upload_cover_box.dart';
import 'package:wayko/widgets/Borrow%20Book/required_field.dart';
import 'package:wayko/widgets/bottom_button.dart';
import 'package:wayko/Services/session_service.dart';
import 'package:wayko/Services/library_arrangement_service.dart';
import 'package:wayko/Services/book_service.dart';

import 'package:wayko/Models/book_model.dart';

class EditBookScreen extends StatefulWidget {
  final BookModel book;

  const EditBookScreen({super.key, required this.book});

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();

  Uint8List? coverImage;

  String? selectedCategory;
  String? selectedFloor;
  String? selectedShelf;
  String? selectedSection;
  String? selectedRack;

  int copies = 1;

  List<String> categories = [];
  List<String> floors = [];
  List<String> shelves = [];
  List<String> sections = [];
  List<String> racks = [];

  @override
  void initState() {
    super.initState();

    titleController.text = widget.book.title;
    authorController.text = widget.book.author;
    descriptionController.text = widget.book.description;
    coverImage = widget.book.coverImage;
    copies = widget.book.copies;
    loadLibraryArrangements();
  }

  Future<void> loadLibraryArrangements() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    List<String> loadedCategories = LibraryArrangementService.getCategories(
      userId,
    ).toSet().toList();
    List<String> loadedFloors = LibraryArrangementService.getFloors(
      userId,
    ).toSet().toList();
    List<String> loadedShelves = LibraryArrangementService.getShelves(
      userId,
    ).toSet().toList();
    List<String> loadedSections = LibraryArrangementService.getSections(
      userId,
    ).toSet().toList();
    List<String> loadedRacks = LibraryArrangementService.getRacks(
      userId,
    ).toSet().toList();

    setState(() {
      categories = loadedCategories;
      floors = loadedFloors;
      shelves = loadedShelves;
      sections = loadedSections;
      racks = loadedRacks;
      selectedCategory = loadedCategories.contains(widget.book.category)
          ? widget.book.category
          : null;
      selectedFloor = loadedFloors.contains(widget.book.floor)
          ? widget.book.floor
          : null;
      selectedShelf = loadedShelves.contains(widget.book.shelf)
          ? widget.book.shelf
          : null;
      selectedSection = loadedSections.contains(widget.book.section)
          ? widget.book.section
          : null;
      selectedRack = loadedRacks.contains(widget.book.rack)
          ? widget.book.rack
          : null;
    });
  }

  Future<void> pickCoverImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();

      setState(() {
        coverImage = imageBytes;
      });
    }
  }

  Future<void> updateBook() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    BookModel updatedBook = widget.book;

    updatedBook.title = titleController.text.trim();
    updatedBook.author = authorController.text.trim();
    updatedBook.description = descriptionController.text.trim();
    updatedBook.category = selectedCategory ?? "";
    updatedBook.coverImage = coverImage;
    int borrowedCopies = widget.book.copies - widget.book.availableCopies;
    if (copies < borrowedCopies) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Cannot reduce copies below borrowed copies ($borrowedCopies).",
          ),
        ),
      );
      return;
    }
    updatedBook.copies = copies;
    updatedBook.availableCopies = copies - borrowedCopies;
    updatedBook.floor = selectedFloor ?? "";
    updatedBook.section = selectedSection ?? "";
    updatedBook.rack = selectedRack ?? "";
    updatedBook.shelf = selectedShelf ?? "";

    await BookService.updateBook(updatedBook);
    Navigator.pop(context);
  }

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
      appBar: AppBar(title: Text("Edit Book")),

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

            UploadCoverBox(onTap: pickCoverImage, image: coverImage),

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
              hint: "Enter description",
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
                      RequiredField(title: "Floor"),

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
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),

          child: BottomButton(onPress: updateBook, title: "Update Book"),
        ),
      ),
    );
  }
}
