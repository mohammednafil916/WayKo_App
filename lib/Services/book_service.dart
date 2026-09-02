import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Services/hive_boxes.dart';

class BookService {
  static Future<void> addBook(BookModel book) async {
    await HiveBoxes.bookBox.add(book);
  }

  static List<BookModel> getBooks(String userId) {
    List<BookModel> books = [];
    for (var book in HiveBoxes.bookBox.values) {
      if (book.userId == userId) {
        books.add(book);
      }
    }
    return books;
  }

  static BookModel? getBook(String bookId, String userId) {
    for (var book in HiveBoxes.bookBox.values) {
      if (book.id == bookId && book.userId == userId) {
        return book;
      }
    }
    return null;
  }

  static Future<void> updateBook(BookModel book) async {
    await book.save();
  }

  static Future<void> deleteBook(BookModel book) async {
    await book.delete();
  }

  static Future<void> toggleFavorite(BookModel book) async {
    book.isFavorite = !book.isFavorite;
    await book.save();
  }
}
