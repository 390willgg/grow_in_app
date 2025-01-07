import 'package:dartz/dartz.dart';
import 'package:grow_in_app/error/failure.dart';

import '../repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository _authRepository;

  LogOutUseCase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await _authRepository.logout();
  }
}
