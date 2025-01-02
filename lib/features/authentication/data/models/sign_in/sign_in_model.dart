import 'package:grow_in_app/features/authentication/domain/entities/sign_in/sign_in.dart';
import 'package:hive/hive.dart';

part 'sign_in_model.g.dart';

@HiveType(typeId: 9)
class SignInModel extends SignIn {
  const SignInModel({required super.email, required super.password});
}
