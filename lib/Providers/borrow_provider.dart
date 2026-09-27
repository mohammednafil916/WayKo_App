import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/Services/borrow_service.dart';

class BorrowNotifier extends Notifier<List<BorrowModel>> {
  @override
  List<BorrowModel> build() {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return [];
    }
    return BorrowService.getBorrows(userId);
  }

  void loadBorrows(String userId) {
    state = BorrowService.getBorrows(userId);
  }

  Future<void> addBorrow(BorrowModel borrow) async {
    await BorrowService.addBorrow(borrow);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BorrowService.getBorrows(userId);
    }
  }

  Future<void> updateBorrow(BorrowModel borrow) async {
    await BorrowService.updateBorrow(borrow);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BorrowService.getBorrows(userId);
    }
  }

  Future<void> deleteBorrow(BorrowModel borrow) async {
    await BorrowService.deleteBorrow(borrow);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BorrowService.getBorrows(userId);
    }
  }

  Future<void> returnBook(BorrowModel borrow) async {
    await BorrowService.returnBook(borrow);
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BorrowService.getBorrows(userId);
    }
  }

  BorrowModel? getBorrow(String borrowId) {
    for (final borrow in state) {
      if (borrow.id == borrowId) {
        return borrow;
      }
    }
    return null;
  }

  void refreshBorrows() {
    final userId = ref.read(currentUserIdProvider);
    if (userId != null) {
      state = BorrowService.getBorrows(userId);
    }
  }

  void clearBorrows() {
    state = [];
  }
}

final borrowProvider = NotifierProvider<BorrowNotifier, List<BorrowModel>>(
  BorrowNotifier.new,
);

class SelectedBorrowStatusNotifier extends Notifier<String> {
  @override
  String build() => "Current";

  void setStatus(String status) {
    state = status;
  }
}

final selectedBorrowStatusProvider =
    NotifierProvider<SelectedBorrowStatusNotifier, String>(
      SelectedBorrowStatusNotifier.new,
    );

final filteredBorrowsProvider = Provider<List<BorrowModel>>((ref) {
  final borrowedBooks = ref.watch(borrowProvider);
  final selectedStatus = ref.watch(selectedBorrowStatusProvider);

  if (selectedStatus == "Current") {
    return borrowedBooks.where((borrow) {
      return borrow.status == "active" &&
          !borrow.returnDate.isBefore(DateTime.now());
    }).toList();
  }

  if (selectedStatus == "Returned") {
    return borrowedBooks.where((borrow) {
      return borrow.status == "returned";
    }).toList();
  }

  if (selectedStatus == "Overdue") {
    return borrowedBooks.where((borrow) {
      return borrow.status == "active" &&
          borrow.returnDate.isBefore(DateTime.now());
    }).toList();
  }

  return [];
});
