import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/Providers/statistics_provider.dart';
import 'package:wayko/widgets/Home/banner_images.dart';
import 'package:wayko/widgets/Home/library_overview_card.dart';
import 'package:wayko/widgets/Home/quick_action_card.dart';
import 'package:wayko/widgets/Home/recently_book_card.dart';

class HomeScreen extends ConsumerWidget {
  final VoidCallback onViewAllBooks;

  const HomeScreen({super.key, required this.onViewAllBooks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final stats = ref.watch(libraryOverviewStatsProvider);
    final recentlyAddedBooks = ref.watch(recentlyAddedBooksProvider);

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
          padding: const EdgeInsets.all(10),
          child: Column(
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
                      value: "${stats.totalBooks}",
                      icon: Icons.library_books,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 179, 231, 255),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Available Books",
                      value: "${stats.availableBooks}",
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
                      value: "${stats.borrowedBooks}",
                      icon: Icons.person,
                      iconColor: Colors.black,
                      color: const Color.fromARGB(255, 255, 184, 179),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: LibraryOverviewCard(
                      title: "Favorites",
                      value: "${stats.favoriteBooks}",
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
                        onPressed: onViewAllBooks,
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
