import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) oneItemSelected;
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.oneItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color.fromARGB(255, 255, 17, 0),
      unselectedItemColor: const Color.fromARGB(255, 0, 12, 143),
      currentIndex: selectedIndex,
      onTap: oneItemSelected,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Book"),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz),
          label: "Borrowed",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
    );
  }
}
