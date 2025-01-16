import 'dart:async';

import 'package:dartz/dartz.dart';
import '../../../../utils/error/failure.dart';
import '../repositories/auth_repository.dart';

class CheckVerificationUseCase {
  final AuthRepository _authRepository;

  CheckVerificationUseCase(this._authRepository);

  Future<Either<Failure, Unit>> call(Completer completer) async {
    return await _authRepository.checkEmailVerified(completer);
  }
}
