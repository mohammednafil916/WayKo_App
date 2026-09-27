import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wayko/Providers/session_provider.dart';
import 'package:wayko/Services/library_arrangement_service.dart';

class AddBookState {
  final List<String> categories;
  final List<String> floors;
  final List<String> sections;
  final List<String> racks;
  final List<String> shelves;

  const AddBookState({
    this.categories = const [],
    this.floors = const [],
    this.sections = const [],
    this.racks = const [],
    this.shelves = const [],
  });

  AddBookState copyWith({
    List<String>? categories,
    List<String>? floors,
    List<String>? sections,
    List<String>? racks,
    List<String>? shelves,
  }) {
    return AddBookState(
      categories: categories ?? this.categories,
      floors: floors ?? this.floors,
      sections: sections ?? this.sections,
      racks: racks ?? this.racks,
      shelves: shelves ?? this.shelves,
    );
  }
}

class AddBookNotifier extends Notifier<AddBookState> {
  @override
  AddBookState build() {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return AddBookState();
    }
    return AddBookState(
      categories: LibraryArrangementService.getCategories(userId),
      floors: LibraryArrangementService.getFloors(userId),
      sections: LibraryArrangementService.getSections(userId),
      racks: LibraryArrangementService.getRacks(userId),
      shelves: LibraryArrangementService.getShelves(userId),
    );
  }

  void loadLibraryArrangements(String userId) {
    state = AddBookState(
      categories: LibraryArrangementService.getCategories(userId),
      floors: LibraryArrangementService.getFloors(userId),
      sections: LibraryArrangementService.getSections(userId),
      racks: LibraryArrangementService.getRacks(userId),
      shelves: LibraryArrangementService.getShelves(userId),
    );
  }

  Future<void> addArrangement(String type, String value) async {
    final userId = ref.read(currentUserIdProvider);
    if (userId == null) {
      return;
    }

    if (type == "category") {
      await LibraryArrangementService.addCategory(userId, value);
    } else if (type == "floor") {
      await LibraryArrangementService.addFloor(userId, value);
    } else if (type == "section") {
      await LibraryArrangementService.addSection(userId, value);
    } else if (type == "rack") {
      await LibraryArrangementService.addRack(userId, value);
    } else if (type == "shelf") {
      await LibraryArrangementService.addShelf(userId, value);
    }

    loadLibraryArrangements(userId);
  }

  void clear() {
    state = AddBookState();
  }
}

final addBookProvider = NotifierProvider<AddBookNotifier, AddBookState>(
  AddBookNotifier.new,
);
