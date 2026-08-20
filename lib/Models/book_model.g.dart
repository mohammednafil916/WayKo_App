// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 1;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      title: fields[2] as String,
      author: fields[3] as String,
      category: fields[4] as String,
      coverImage: fields[5] as Uint8List?,
      copies: fields[6] as int,
      availableCopies: fields[7] as int,
      floor: fields[8] as String,
      section: fields[9] as String,
      rack: fields[10] as String,
      shelf: fields[11] as String,
      isFavorite: fields[12] as bool,
      createdAt: fields[13] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.coverImage)
      ..writeByte(6)
      ..write(obj.copies)
      ..writeByte(7)
      ..write(obj.availableCopies)
      ..writeByte(8)
      ..write(obj.floor)
      ..writeByte(9)
      ..write(obj.section)
      ..writeByte(10)
      ..write(obj.rack)
      ..writeByte(11)
      ..write(obj.shelf)
      ..writeByte(12)
      ..write(obj.isFavorite)
      ..writeByte(13)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
