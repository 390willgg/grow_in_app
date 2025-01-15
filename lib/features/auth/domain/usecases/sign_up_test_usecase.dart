import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../entities/user/user.dart';
import '../repositories/auth_repository.dart';

class SignUpTestUseCase {
  final AuthRepository repository;

  SignUpTestUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(
    UserEntity user,
    String password,
  ) async {
    return await repository.signUpTest(user, password);
  }
}
