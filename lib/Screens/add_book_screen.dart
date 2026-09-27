import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Providers/add_book_provider.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/widgets/Add%20Book/book_copies_counter.dart';
import 'package:wayko/widgets/Add%20Book/book_dropdown.dart';
import 'package:wayko/widgets/Add%20Book/book_text_field.dart';
import 'package:wayko/widgets/Add%20Book/upload_cover_box.dart';
import 'package:wayko/widgets/Borrow%20Book/required_field.dart';
import 'package:wayko/widgets/bottom_button.dart';

class AddBookScreen extends ConsumerStatefulWidget {
  const AddBookScreen({super.key});

  @override
  ConsumerState<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends ConsumerState<AddBookScreen> {
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

  Future<void> addNewArrangement(String type) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      return;
    }

    String title = type[0].toUpperCase() + type.substring(1);

    String? value = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          title: Text("Add $title"),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: "Enter $title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () {
                String newValue = controller.text.trim();

                if (newValue.isNotEmpty) {
                  Navigator.pop(context, newValue);
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (value == null || value.isEmpty) {
      return;
    }

    await ref.read(addBookProvider.notifier).addArrangement(type, value);

    setState(() {
      if (type == "category") {
        selectedCategory = value;
      } else if (type == "floor") {
        selectedFloor = value;
      } else if (type == "section") {
        selectedSection = value;
      } else if (type == "rack") {
        selectedRack = value;
      } else if (type == "shelf") {
        selectedShelf = value;
      }
    });
  }

  Future<void> saveBook() async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      return;
    }

    if (titleController.text.trim().isEmpty ||
        authorController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill title and author")));
      return;
    }

    BookModel book = BookModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      userId: userId,
      title: titleController.text.trim(),
      author: authorController.text.trim(),
      category: selectedCategory ?? "",
      coverImage: coverImage,
      description: descriptionController.text.trim(),
      copies: copies,
      availableCopies: copies,
      floor: selectedFloor ?? "",
      section: selectedSection ?? "",
      rack: selectedRack ?? "",
      shelf: selectedShelf ?? "",
      isFavorite: false,
      createdAt: DateTime.now(),
    );

    await ref.read(bookProvider.notifier).addBook(book);

    if (!mounted) return;

    Navigator.pop(context);
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

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arrangementState = ref.watch(addBookProvider);

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
              items: arrangementState.categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
              onAddNew: () => addNewArrangement("category"),
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
                        items: arrangementState.floors,
                        onChanged: (value) {
                          setState(() {
                            selectedFloor = value;
                          });
                        },
                        onAddNew: () => addNewArrangement("floor"),
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
                        items: arrangementState.racks,
                        onChanged: (value) {
                          setState(() {
                            selectedRack = value;
                          });
                        },
                        onAddNew: () => addNewArrangement("rack"),
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
                        items: arrangementState.sections,
                        onChanged: (value) {
                          setState(() {
                            selectedSection = value;
                          });
                        },
                        onAddNew: () => addNewArrangement("section"),
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
                        items: arrangementState.shelves,
                        onChanged: (value) {
                          setState(() {
                            selectedShelf = value;
                          });
                        },
                        onAddNew: () => addNewArrangement("shelf"),
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
          child: BottomButton(onPress: saveBook, title: "Save Book"),
        ),
      ),
    );
  }
}
