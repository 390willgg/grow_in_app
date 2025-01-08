import 'package:hive/hive.dart';

import '../../../domain/entities/sign_up/sign_up.dart';

part 'sign_up_model.g.dart';

@HiveType(typeId: 8)
class SignUpModel extends SignUp {
  const SignUpModel({
    required super.name,
    required super.email,
    required super.password,
    required super.repeatPassword,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      repeatPassword: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
