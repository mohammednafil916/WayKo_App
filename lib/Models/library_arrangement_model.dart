import 'package:hive/hive.dart';

part 'library_arrangement_model.g.dart';

@HiveType(typeId: 3)
class LibraryArrangementModel extends HiveObject {
  @HiveField(0)
  String userId;

  @HiveField(1)
  List<String> categories;

  @HiveField(2)
  List<String> floors;

  @HiveField(3)
  List<String> sections;

  @HiveField(4)
  List<String> racks;

  @HiveField(5)
  List<String> shelves;

  LibraryArrangementModel({
    required this.userId,
    required this.categories,
    required this.floors,
    required this.sections,
    required this.racks,
    required this.shelves,
  });
}
