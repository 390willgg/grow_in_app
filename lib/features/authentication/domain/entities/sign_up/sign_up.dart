import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'sign_up.g.dart';

@HiveType(typeId: 7)
class SignUp extends Equatable {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String repeatPassword;

  const SignUp({
    required this.name,
    required this.email,
    required this.password,
    required this.repeatPassword,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
        repeatPassword,
      ];
}
