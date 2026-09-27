import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/Services/book_service.dart';

class BookNotifier extends Notifier<List<BookModel>> {
  @override
  List<BookModel> build() {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return [];
    }
    return BookService.getBooks(userId);
  }

  void loadBooks(String userId) {
    state = BookService.getBooks(userId);
  }

  Future<void> addBook(BookModel book) async {
    await BookService.addBook(book);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BookService.getBooks(userId);
    }
  }

  Future<void> updateBook(BookModel book) async {
    await BookService.updateBook(book);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BookService.getBooks(userId);
    }
  }

  Future<void> deleteBook(BookModel book) async {
    await BookService.deleteBook(book);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BookService.getBooks(userId);
    }
  }

  Future<void> toggleFavorite(BookModel book) async {
    await BookService.toggleFavorite(book);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BookService.getBooks(userId);
    }
  }

  BookModel? getBook(String bookId) {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      return null;
    }
    return BookService.getBook(bookId, userId);
  }

  void refreshBooks() {
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BookService.getBooks(userId);
    }
  }

  void clearBooks() {
    state = [];
  }
}

final bookProvider = NotifierProvider<BookNotifier, List<BookModel>>(
  BookNotifier.new,
);

final favoriteBooksProvider = Provider<List<BookModel>>((ref) {
  final books = ref.watch(bookProvider);
  return books.where((book) => book.isFavorite).toList();
});

final recentlyAddedBooksProvider = Provider<List<BookModel>>((ref) {
  final books = List<BookModel>.from(ref.watch(bookProvider));
  books.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return books.take(3).toList();
});

class SelectedCategoryNotifier extends Notifier<String> {
  @override
  String build() => "All";

  void setCategory(String category) {
    state = category;
  }
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, String>(
      SelectedCategoryNotifier.new,
    );

final filteredBooksProvider = Provider<List<BookModel>>((ref) {
  final books = ref.watch(bookProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);

  if (selectedCategory == "All") {
    return books;
  }
  return books.where((book) => book.category == selectedCategory).toList();
});
