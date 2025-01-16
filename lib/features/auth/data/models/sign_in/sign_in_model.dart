import 'package:hive/hive.dart';

import '../../../domain/entities/sign_in/sign_in.dart';

part 'sign_in_model.g.dart';

@HiveType(typeId: 9)
class SignInModel extends SignIn {
  const SignInModel({
    required super.email,
    required super.password,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    return SignInModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
