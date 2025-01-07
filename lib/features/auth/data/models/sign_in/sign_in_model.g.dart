// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignInModelAdapter extends TypeAdapter<SignInModel> {
  @override
  final int typeId = 9;

  @override
  SignInModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignInModel(
      email: fields[1] as String,
      password: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignInModel obj) {
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
      other is SignInModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
