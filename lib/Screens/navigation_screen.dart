import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/navigation_provider.dart';
import 'package:wayko/Screens/book_screen.dart';
import 'package:wayko/Screens/borrowed_books_screen.dart';
import 'package:wayko/Screens/favorites_screen.dart';
import 'package:wayko/Screens/home_screen.dart';
import 'package:wayko/Screens/profile_screen.dart';
import 'package:wayko/widgets/bottom_nav_bar.dart';

class NavigationScreen extends ConsumerWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    final List<Widget> screens = [
      HomeScreen(
        onViewAllBooks: () {
          ref.read(navigationIndexProvider.notifier).setIndex(1);
        },
      ),
      const BookScreen(),
      const BorrowedBooksScreen(),
      const FavoritesScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        oneItemSelected: (index) {
          ref.read(navigationIndexProvider.notifier).setIndex(index);
        },
      ),
    );
  }
}
