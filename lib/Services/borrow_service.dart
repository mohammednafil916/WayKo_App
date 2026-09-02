import 'package:wayko/Services/hive_boxes.dart';
import 'package:wayko/Models/borrow_model.dart';

class BorrowService {
  static Future<void> addBorrow(BorrowModel borrow) async {
    await HiveBoxes.borrowBox.add(borrow);
  }

  static List<BorrowModel> getBorrows(String userId) {
    List<BorrowModel> borrows = [];
    for (var borrow in HiveBoxes.borrowBox.values) {
      if (borrow.userId == userId) {
        borrows.add(borrow);
      }
    }
    return borrows;
  }

  static BorrowModel? getBorrow(String borrowId, String userId) {
    for (var borrow in HiveBoxes.borrowBox.values) {
      if (borrow.id == borrowId && borrow.userId == userId) {
        return borrow;
      }
    }
    return null;
  }

  static Future<void> updateBorrow(BorrowModel borrow) async {
    await borrow.save();
  }

  static Future<void> returnBook(BorrowModel borrow) async {
    borrow.status = "returned";
    borrow.actualReturnDate = DateTime.now();
    await borrow.save();
  }

  static Future<void> deleteBorrow(BorrowModel borrow) async {
    await borrow.delete();
  }
}
