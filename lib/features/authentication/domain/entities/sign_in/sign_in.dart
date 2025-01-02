import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'sign_in.g.dart';

@HiveType(typeId: 6)
class SignIn extends Equatable {
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String password;

  const SignIn({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
