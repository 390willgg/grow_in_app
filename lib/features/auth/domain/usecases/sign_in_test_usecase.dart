import 'package:dartz/dartz.dart';

import '../../../../utils/error/failure.dart';
import '../repositories/auth_repository.dart';

class SignInTestUseCase {
  final AuthRepository repository;

  SignInTestUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) async {
    return await repository.signInTest(email, password);
  }
}
