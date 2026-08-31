import 'package:flutter/material.dart';
import 'package:wayko/widgets/Home/banner_images.dart';
import 'package:wayko/widgets/Home/library_overview_card.dart';
import 'package:wayko/widgets/Home/quick_action_card.dart';
import 'package:wayko/widgets/Home/recently_book_card.dart';
import 'package:wayko/Models/user_model.dart';
import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Services/session_service.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Services/book_service.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onViewAllBooks;

  const HomeScreen({super.key, required this.onViewAllBooks});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  UserModel? user;
  int totalBooks = 0;
  int availableBooks = 0;
  int borrowedBooks = 0;
  int favoriteBooks = 0;
  List<BookModel> recentlyAddedBooks = [];

  void refreshHome() {
    loadUser();
    loadStatistics();
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    loadStatistics();
  }

  Future<void> loadUser() async {
    String? userId = await SessionService.getLoggedUserId();
    for (UserModel currentUser in HiveBoxes.userBox.values) {
      if (currentUser.id == userId) {
        setState(() {
          user = currentUser;
        });
        break;
      }
    }
  }

  Future<void> loadStatistics() async {
    String? userId = await SessionService.getLoggedUserId();
    if (userId == null) {
      return;
    }
    List<BookModel> books = BookService.getBooks(userId);
    books.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    List<BookModel> recentBooks = books.take(3).toList();
    int total = 0;
    int available = 0;
    int favorites = 0;
    for (BookModel book in books) {
      total += book.copies;
      available += book.availableCopies;
      if (book.isFavorite) {
        favorites++;
      }
    }
    int borrowed = total - available;
    setState(() {
      totalBooks = total;
      availableBooks = available;
      borrowedBooks = borrowed;
      favoriteBooks = favorites;
      recentlyAddedBooks = recentBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("WayKo"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, ${user?.username ?? "User"}👋",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              Text(
                "Here's what's happening in your library",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 10),
              BannerImages(),
              SizedBox(height: 15),
              Text(
                "Library Overview",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 12, 143),
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Total Books",
                      value: "$totalBooks",
                      icon: Icons.library_books,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 179, 231, 255),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Available Books",
                      value: "$availableBooks",
                      icon: Icons.book,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 213, 245, 177),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Borrowed Books",
                      value: "$borrowedBooks",
                      icon: Icons.person,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 255, 184, 179),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Favorites",
                      value: "$favoriteBooks",
                      icon: Icons.star_border,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 179, 231, 255),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Quick Actions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color.fromARGB(255, 0, 12, 143),
                ),
              ),
              SizedBox(height: 5),
              QuickActionCard(),
              SizedBox(height: 15),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recently added",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Color.fromARGB(255, 0, 12, 143),
                        ),
                      ),
                      TextButton(
                        onPressed: widget.onViewAllBooks,
                        child: Text(
                          "View all",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 0, 12, 143),
                          ),
                        ),
                      ),
                    ],
                  ),
                  recentlyAddedBooks.isEmpty
                      ? Center(
                          child: Text(
                            "No books added yet",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: recentlyAddedBooks.map((book) {
                            return RecentlyBookCard(
                              image: book.coverImage,
                              title: book.title,
                              category: book.category,
                            );
                          }).toList(),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
