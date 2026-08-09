import 'package:flutter/material.dart';

import 'package:wayko/Screens/book_details_screen.dart';
import 'package:wayko/Screens/borrowed_book_details_screen.dart';
import 'package:wayko/Screens/borrow_book_screen.dart';
import 'package:wayko/Screens/edit_book_screen.dart';
import 'package:wayko/Screens/splash_screen.dart';
import 'package:wayko/Screens/login_screen.dart';
import 'package:wayko/Screens/register_screen.dart';
import 'package:wayko/Screens/home_screen.dart';
import 'package:wayko/Screens/book_screen.dart';
import 'package:wayko/Screens/borrowed_books_screen.dart';
import 'package:wayko/Screens/favorites_screen.dart';
import 'package:wayko/Screens/profile_screen.dart';
import 'package:wayko/Screens/add_book_screen.dart';
import 'package:wayko/Screens/statistics_screen.dart';
import 'package:wayko/Screens/navigation_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String books = '/books';
  static const String favorites = '/favorites';
  static const String profile = '/profile';
  static const String addBook = '/add-book';
  static const String editBook = '/edit-book';
  static const String bookDetails = '/book-details';
  static const String borrowedBooks = '/borrowed-books';
  static const String borrowedBookDetails = '/borrowed-book-details';
  static const String borrowBook = '/borrow-book';
  static const String statistics = '/statistics';
  static const String navigation = '/navigation';

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case books:
        return MaterialPageRoute(builder: (_) => BookScreen());

      case favorites:
        return MaterialPageRoute(builder: (_) => FavoritesScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case addBook:
        return MaterialPageRoute(builder: (_) => AddBookScreen());

      case editBook:
        return MaterialPageRoute(builder: (_) => EditBookScreen());

      case bookDetails:
        return MaterialPageRoute(builder: (_) => BookDetailsScreen());

      case borrowBook:
        return MaterialPageRoute(builder: (_) => BorrowBookScreen());

      case borrowedBooks:
        return MaterialPageRoute(builder: (_) => BorrowedBooksScreen());

      case borrowedBookDetails:
        return MaterialPageRoute(builder: (_) => BorrowedBookDetailsScreen());

      case statistics:
        return MaterialPageRoute(builder: (_) => StatisticsScreen());

      case navigation:
        return MaterialPageRoute(builder: (_) => NavigationScreen());

      default:
        return MaterialPageRoute(builder: (_) => NavigationScreen());
    }
  }
}
