import 'package:dartz/dartz.dart';
import 'package:grow_in_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:grow_in_app/utils/error/failure.dart';

class LogOutTestUseCase {
  final AuthRepository _authRepository;

  LogOutTestUseCase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await _authRepository.logOutTest();
  }
}
