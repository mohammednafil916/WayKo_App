import 'package:hive_flutter/hive_flutter.dart';

import 'package:wayko/Models/book_model.dart';
import 'package:wayko/Models/borrow_model.dart';
import 'package:wayko/Models/library_arrangement_model.dart';
import 'package:wayko/Models/user_model.dart';

class HiveBoxes {
  static late Box<UserModel> userBox;
  static late Box<BookModel> bookBox;
  static late Box<BorrowModel> borrowBox;
  static late Box<LibraryArrangementModel> arrangementBox;

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(BookModelAdapter());
    Hive.registerAdapter(BorrowModelAdapter());
    Hive.registerAdapter(LibraryArrangementModelAdapter());

    userBox = await Hive.openBox<UserModel>('userBox');
    bookBox = await Hive.openBox<BookModel>('bookBox');
    borrowBox = await Hive.openBox<BorrowModel>('borrowBox');
    arrangementBox = await Hive.openBox<LibraryArrangementModel>(
      'arrangementBox',
    );
  }
}
