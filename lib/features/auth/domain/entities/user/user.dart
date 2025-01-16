import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 11)
class UserEntity extends Equatable {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final String? deviceId;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.deviceId,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? deviceId,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  @override
  List<Object?> get props => [id, email, name, deviceId];
}
