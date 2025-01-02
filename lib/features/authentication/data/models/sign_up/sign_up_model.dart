import 'package:grow_in_app/features/authentication/domain/entities/sign_up/sign_up.dart';
import 'package:hive/hive.dart';

part 'sign_up_model.g.dart';

@HiveType(typeId: 8)
class SignUpModel extends SignUp {
  const SignUpModel({
    required super.name,
    required super.email,
    required super.password,
    required super.repeatPassword,
  });
}
