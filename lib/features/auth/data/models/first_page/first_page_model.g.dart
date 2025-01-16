// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_page_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FirstPageModelAdapter extends TypeAdapter<FirstPageModel> {
  @override
  final int typeId = 13;

  @override
  FirstPageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FirstPageModel(
      isLoggedIn: fields[1] as bool,
      isEmailVerified: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FirstPageModel obj) {
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
      other is FirstPageModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
