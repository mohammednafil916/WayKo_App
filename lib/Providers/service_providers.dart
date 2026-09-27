import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Services/authentication_service.dart';
import 'package:wayko/Services/book_service.dart';
import 'package:wayko/Services/borrow_service.dart';
import 'package:wayko/Services/library_arrangement_service.dart';
import 'package:wayko/Services/session_service.dart';

final authServiceProvider = Provider<AuthenticationService>((ref) {
  return AuthenticationService();
});

final bookServiceProvider = Provider<BookService>((ref) {
  return BookService();
});

final borrowServiceProvider = Provider<BorrowService>((ref) {
  return BorrowService();
});

final libraryArrangementServiceProvider = Provider<LibraryArrangementService>((
  ref,
) {
  return LibraryArrangementService();
});

final sessionServiceProvider = Provider<SessionService>((ref) {
  return SessionService();
});
