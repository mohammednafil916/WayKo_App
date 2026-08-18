import 'package:flutter/material.dart';
import 'package:wayko/Services/authentication_service.dart';
import 'package:wayko/widgets/Home/banner_images.dart';
import 'package:wayko/widgets/Home/library_overview_card.dart';
import 'package:wayko/widgets/Home/quick_action_card.dart';
import 'package:wayko/widgets/Home/recently_book_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onViewAllBooks;
  const HomeScreen({super.key, required this.onViewAllBooks});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String username = AuthenticationService.registerName ?? "User";
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
                "Welcome, $username👋",
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
                      value: "1,250",
                      icon: Icons.library_books,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 179, 231, 255),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Available Books",
                      value: "1,100 ",
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
                      value: "150",
                      icon: Icons.person,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 255, 184, 179),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Favorites",
                      value: "150",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RecentlyBookCard(
                        image: "assets/images/book1.jpg",
                        title: "title",
                        category: "category",
                      ),
                      RecentlyBookCard(
                        image: "assets/images/book2.jpg",
                        title: "title",
                        category: "category",
                      ),
                      RecentlyBookCard(
                        image: "assets/images/book3.jpg",
                        title: "title",
                        category: "category",
                      ),
                    ],
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
