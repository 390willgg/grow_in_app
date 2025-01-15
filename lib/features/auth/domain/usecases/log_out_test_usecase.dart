import 'package:dartz/dartz.dart';
import 'package:grow_in_app/utils/error/failure.dart';
import 'package:grow_in_app/features/auth/domain/repositories/auth_repository.dart';

class LogOutUseCase {
  final AuthRepository _authRepository;

  LogOutUseCase(this._authRepository);

  Future<Either<Failure, void>> call() async {
    return await _authRepository.logOutTest();
  }
}
