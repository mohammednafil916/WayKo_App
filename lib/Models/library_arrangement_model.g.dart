// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_arrangement_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibraryArrangementModelAdapter
    extends TypeAdapter<LibraryArrangementModel> {
  @override
  final int typeId = 2;

  @override
  LibraryArrangementModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibraryArrangementModel(
      userId: fields[0] as String,
      categories: (fields[1] as List).cast<String>(),
      floors: (fields[2] as List).cast<String>(),
      sections: (fields[3] as List).cast<String>(),
      racks: (fields[4] as List).cast<String>(),
      shelves: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LibraryArrangementModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.categories)
      ..writeByte(2)
      ..write(obj.floors)
      ..writeByte(3)
      ..write(obj.sections)
      ..writeByte(4)
      ..write(obj.racks)
      ..writeByte(5)
      ..write(obj.shelves);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibraryArrangementModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
