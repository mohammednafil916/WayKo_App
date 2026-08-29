import 'package:hive/hive.dart';
part 'borrow_model.g.dart';

@HiveType(typeId: 2)
class BorrowModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String bookId;

  @HiveField(3)
  String borrowerName;

  @HiveField(4)
  String borrowerContact;

  @HiveField(5)
  DateTime borrowDate;

  @HiveField(6)
  DateTime returnDate;

  @HiveField(7)
  String status;

  @HiveField(8)
  String notes;

  @HiveField(9)
  DateTime? actualReturnDate;

  BorrowModel({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.borrowerName,
    required this.borrowerContact,
    required this.borrowDate,
    required this.returnDate,
    required this.status,
    required this.notes,
    this.actualReturnDate,
  });
}
