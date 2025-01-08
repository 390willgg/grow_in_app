import 'package:hive/hive.dart';

import '../../../domain/entities/sign_in/sign_in.dart';

part 'sign_in_model.g.dart';

@HiveType(typeId: 9)
class SignInModel extends SignIn {
  const SignInModel({required super.email, required super.password});
}
