import 'package:hive/hive.dart';

import '../../../domain/entities/user/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 12)
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.deviceId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['userId'],
      email: json['email'],
      name: json['name'],
      deviceId: json['device_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': super.email,
      'name': super.name,
      'device_id': super.deviceId,
    };
  }

  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? deviceId,
  }) {
    return UserModel(
      id: id ?? super.id,
      email: email ?? super.email,
      name: name ?? super.name,
      deviceId: deviceId ?? super.deviceId,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: super.id,
      email: super.email,
      name: super.name,
      deviceId: super.deviceId,
    );
  }
}
