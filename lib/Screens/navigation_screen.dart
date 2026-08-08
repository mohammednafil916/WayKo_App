import 'package:flutter/material.dart';
import 'package:wayko/Screens/book_screen.dart';
import 'package:wayko/Screens/borrowed_books_screen.dart';
import 'package:wayko/Screens/favorites_screen.dart';
import 'package:wayko/Screens/home_screen.dart';
import 'package:wayko/Screens/profile_screen.dart';
import 'package:wayko/widgets/bottom_nav_bar.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const BookScreen(),
    const BorrowedBooksScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        oneItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
