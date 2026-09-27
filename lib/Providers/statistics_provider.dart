import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Providers/add_book_provider.dart';
import 'package:wayko/Providers/book_provider.dart';
import 'package:wayko/Providers/borrow_provider.dart';

class DateRangeState {
  final DateTime? fromDate;
  final DateTime? toDate;

  const DateRangeState({this.fromDate, this.toDate});

  DateRangeState copyWith({
    DateTime? fromDate,
    DateTime? toDate,
    bool clearFromDate = false,
    bool clearToDate = false,
  }) {
    return DateRangeState(
      fromDate: clearFromDate ? null : (fromDate ?? this.fromDate),
      toDate: clearToDate ? null : (toDate ?? this.toDate),
    );
  }
}

class StatsDateRangeNotifier extends Notifier<DateRangeState> {
  @override
  DateRangeState build() {
    return DateRangeState();
  }

  void setFromDate(DateTime? date) {
    state = state.copyWith(fromDate: date);
  }

  void setToDate(DateTime? date) {
    state = state.copyWith(toDate: date);
  }

  void clearFilter() {
    state = DateRangeState();
  }
}

final statsDateRangeProvider =
    NotifierProvider<StatsDateRangeNotifier, DateRangeState>(
      StatsDateRangeNotifier.new,
    );

class OverviewStats {
  final int totalBooks;
  final int availableBooks;
  final int borrowedBooks;
  final int favoriteBooks;

  const OverviewStats({
    required this.totalBooks,
    required this.availableBooks,
    required this.borrowedBooks,
    required this.favoriteBooks,
  });
}

final libraryOverviewStatsProvider = Provider<OverviewStats>((ref) {
  final books = ref.watch(bookProvider);
  int total = 0;
  int available = 0;
  int favorites = 0;

  for (final book in books) {
    total += book.copies;
    available += book.availableCopies;
    if (book.isFavorite) {
      favorites++;
    }
  }

  final borrowed = total - available;

  return OverviewStats(
    totalBooks: total,
    availableBooks: available,
    borrowedBooks: borrowed,
    favoriteBooks: favorites,
  );
});

class DetailedStats {
  final int totalBooks;
  final int availableBooks;
  final int borrowedBooks;
  final int returnedBooks;
  final int overdueBooks;
  final int favoriteBooks;
  final int categoriesCount;
  final int floorsCount;
  final int racksCount;
  final int shelvesCount;

  final double availablePercentage;
  final double borrowedPercentage;
  final double returnedPercentage;
  final double overduePercentage;

  final bool isDateFilterActive;
  final bool hasDateActivity;

  const DetailedStats({
    required this.totalBooks,
    required this.availableBooks,
    required this.borrowedBooks,
    required this.returnedBooks,
    required this.overdueBooks,
    required this.favoriteBooks,
    required this.categoriesCount,
    required this.floorsCount,
    required this.racksCount,
    required this.shelvesCount,
    required this.availablePercentage,
    required this.borrowedPercentage,
    required this.returnedPercentage,
    required this.overduePercentage,
    required this.isDateFilterActive,
    required this.hasDateActivity,
  });
}

bool _isBorrowInSelectedRange(
  BorrowModel borrow,
  DateTime? fromDate,
  DateTime? toDate,
) {
  if (fromDate == null || toDate == null) {
    return true;
  }

  final borrowDate = DateTime(
    borrow.borrowDate.year,
    borrow.borrowDate.month,
    borrow.borrowDate.day,
  );

  final startDate = DateTime(fromDate.year, fromDate.month, fromDate.day);

  final endDate = DateTime(toDate.year, toDate.month, toDate.day);

  return !borrowDate.isBefore(startDate) && !borrowDate.isAfter(endDate);
}

bool _isReturnedInSelectedRange(
  BorrowModel borrow,
  DateTime? fromDate,
  DateTime? toDate,
) {
  if (borrow.actualReturnDate == null) {
    return false;
  }

  if (fromDate == null || toDate == null) {
    return true;
  }

  final returnedDate = DateTime(
    borrow.actualReturnDate!.year,
    borrow.actualReturnDate!.month,
    borrow.actualReturnDate!.day,
  );

  final startDate = DateTime(fromDate.year, fromDate.month, fromDate.day);

  final endDate = DateTime(toDate.year, toDate.month, toDate.day);

  return !returnedDate.isBefore(startDate) && !returnedDate.isAfter(endDate);
}

final detailedStatisticsProvider = Provider<DetailedStats>((ref) {
  final books = ref.watch(bookProvider);
  final allBorrows = ref.watch(borrowProvider);
  final arrangementState = ref.watch(addBookProvider);
  final dateRange = ref.watch(statsDateRangeProvider);

  final fromDate = dateRange.fromDate;
  final toDate = dateRange.toDate;

  final totalBooks = books.fold(0, (sum, book) => sum + book.copies);
  final availableBooks = books.fold(
    0,
    (sum, book) => sum + book.availableCopies,
  );

  final borrowedBooks = allBorrows
      .where(
        (borrow) =>
            borrow.status == "active" &&
            !borrow.returnDate.isBefore(DateTime.now()) &&
            _isBorrowInSelectedRange(borrow, fromDate, toDate),
      )
      .length;

  final returnedBooks = allBorrows
      .where(
        (borrow) =>
            borrow.status == "returned" &&
            _isReturnedInSelectedRange(borrow, fromDate, toDate),
      )
      .length;

  final overdueBooks = allBorrows
      .where(
        (borrow) =>
            borrow.status == "active" &&
            borrow.returnDate.isBefore(DateTime.now()) &&
            _isBorrowInSelectedRange(borrow, fromDate, toDate),
      )
      .length;

  final favoriteBooks = books.where((book) => book.isFavorite).length;

  final categoriesCount = arrangementState.categories.length;
  final floorsCount = arrangementState.floors.length;
  final racksCount = arrangementState.racks.length;
  final shelvesCount = arrangementState.shelves.length;

  final isDateFilterActive = fromDate != null && toDate != null;
  final hasDateActivity =
      borrowedBooks > 0 || returnedBooks > 0 || overdueBooks > 0;

  double availPct = 0;
  if (totalBooks > 0) {
    availPct = availableBooks / totalBooks * 100;
  }

  double borPct = 0;
  if (isDateFilterActive) {
    final totalActivity = borrowedBooks + returnedBooks + overdueBooks;
    if (totalActivity > 0) {
      borPct = borrowedBooks / totalActivity * 100;
    }
  } else if (totalBooks > 0) {
    borPct = borrowedBooks / totalBooks * 100;
  }

  double retPct = 0;
  double overPct = 0;
  final totalActivity = borrowedBooks + returnedBooks + overdueBooks;
  if (totalActivity > 0) {
    retPct = returnedBooks / totalActivity * 100;
    overPct = overdueBooks / totalActivity * 100;
  }

  return DetailedStats(
    totalBooks: totalBooks,
    availableBooks: availableBooks,
    borrowedBooks: borrowedBooks,
    returnedBooks: returnedBooks,
    overdueBooks: overdueBooks,
    favoriteBooks: favoriteBooks,
    categoriesCount: categoriesCount,
    floorsCount: floorsCount,
    racksCount: racksCount,
    shelvesCount: shelvesCount,
    availablePercentage: availPct,
    borrowedPercentage: borPct,
    returnedPercentage: retPct,
    overduePercentage: overPct,
    isDateFilterActive: isDateFilterActive,
    hasDateActivity: hasDateActivity,
  );
});
