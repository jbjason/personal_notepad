// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyNoteAdapter extends TypeAdapter<MyNote> {
  @override
  final int typeId = 2;

  @override
  MyNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyNote(
      id: fields[2] as String,
      title: fields[0] as String,
      description: fields[1] as String,
      snapImage: fields[4] as String?,
      imageDir: fields[3] as String?,
      dateTime: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MyNote obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.imageDir)
      ..writeByte(4)
      ..write(obj.snapImage)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
