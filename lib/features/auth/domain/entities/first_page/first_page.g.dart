// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_page.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirstPageAdapter extends TypeAdapter<FirstPage> {
  @override
  final int typeId = 10;

  @override
  FirstPage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirstPage(
      isLoggedIn: fields[1] as bool,
      isEmailVerified: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FirstPage obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.isLoggedIn)
      ..writeByte(2)
      ..write(obj.isEmailVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FirstPageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
