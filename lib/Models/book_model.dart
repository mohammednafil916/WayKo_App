import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'book_model.g.dart';

@HiveType(typeId: 1)
class BookModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String userId;

  @HiveField(2)
  String title;

  @HiveField(3)
  String author;

  @HiveField(4)
  String category;

  @HiveField(5)
  Uint8List? coverImage;

  @HiveField(6)
  int copies;

  @HiveField(7)
  int availableCopies;

  @HiveField(8)
  String floor;

  @HiveField(9)
  String section;

  @HiveField(10)
  String rack;

  @HiveField(11)
  String shelf;

  @HiveField(12)
  bool isFavorite;

  @HiveField(13)
  DateTime createdAt;

  BookModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.author,
    required this.category,
    this.coverImage,
    required this.copies,
    required this.availableCopies,
    required this.floor,
    required this.section,
    required this.rack,
    required this.shelf,
    required this.isFavorite,
    required this.createdAt,
  });
}
