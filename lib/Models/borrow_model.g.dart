// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BorrowModelAdapter extends TypeAdapter<BorrowModel> {
  @override
  final int typeId = 2;

  @override
  BorrowModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BorrowModel(
      id: fields[0] as String,
      userId: fields[1] as String,
      bookId: fields[2] as String,
      borrowerName: fields[3] as String,
      borrowerContact: fields[4] as String,
      borrowDate: fields[5] as DateTime,
      returnDate: fields[6] as DateTime,
      status: fields[7] as String,
      notes: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BorrowModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.bookId)
      ..writeByte(3)
      ..write(obj.borrowerName)
      ..writeByte(4)
      ..write(obj.borrowerContact)
      ..writeByte(5)
      ..write(obj.borrowDate)
      ..writeByte(6)
      ..write(obj.returnDate)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BorrowModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
