import 'package:wayko/Models/library_arrangement_model.dart';
import 'package:wayko/Services/hive_boxes.dart';

class LibraryArrangementService {
  static LibraryArrangementModel? getArrangement(String userId) {
    for (var arrangement in HiveBoxes.arrangementBox.values) {
      if (arrangement.userId == userId) {
        return arrangement;
      }
    }
    return null;
  }

  static Future<void> createArrangement(String userId) async {
    LibraryArrangementModel arrangement = LibraryArrangementModel(
      userId: userId,
      categories: [],
      floors: [],
      sections: [],
      racks: [],
      shelves: [],
    );
    await HiveBoxes.arrangementBox.add(arrangement);
  }

  static Future<void> addCategory(String userId, String category) async {
    LibraryArrangementModel? arrangement = getArrangement(userId);

    if (arrangement != null) {
      if (!arrangement.categories.contains(category)) {
        arrangement.categories.add(category);
        await arrangement.save();
      }
    }
  }

  static Future<void> addFloor(String userId, String floor) async {
    LibraryArrangementModel? arrangement = getArrangement(userId);

    if (arrangement != null) {
      if (!arrangement.floors.contains(floor)) {
        arrangement.floors.add(floor);
        await arrangement.save();
      }
    }
  }

  static Future<void> addSection(String userId, String section) async {
    LibraryArrangementModel? arrangement = getArrangement(userId);

    if (arrangement != null) {
      if (!arrangement.sections.contains(section)) {
        arrangement.sections.add(section);
        await arrangement.save();
      }
    }
  }

  static Future<void> addRack(String userId, String rack) async {
    LibraryArrangementModel? arrangement = getArrangement(userId);

    if (arrangement != null) {
      if (!arrangement.racks.contains(rack)) {
        arrangement.racks.add(rack);
        await arrangement.save();
      }
    }
  }

  static Future<void> addShelf(String userId, String shelf) async {
    LibraryArrangementModel? arrangement = getArrangement(userId);

    if (arrangement != null) {
      if (!arrangement.shelves.contains(shelf)) {
        arrangement.shelves.add(shelf);
        await arrangement.save();
      }
    }
  }
}
