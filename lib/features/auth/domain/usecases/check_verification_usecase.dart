import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:grow_in_app/error/failure.dart';
import 'package:grow_in_app/features/auth/domain/repositories/auth_repository.dart';

class CheckVerificationUseCase {
  final AuthRepository _authRepository;

  CheckVerificationUseCase(this._authRepository);

  Future<Either<Failure, Unit>> call(Completer completer) async {
    return await _authRepository.checkEmailVerified(completer);
  }
}
