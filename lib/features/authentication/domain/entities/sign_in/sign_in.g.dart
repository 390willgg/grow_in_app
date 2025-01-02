// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignInAdapter extends TypeAdapter<SignIn> {
  @override
  final int typeId = 6;

  @override
  SignIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignIn(
      email: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignIn obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
