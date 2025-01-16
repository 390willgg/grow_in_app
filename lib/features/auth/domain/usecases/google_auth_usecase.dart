import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/error/failure.dart';
import '../repositories/auth_repository.dart';

class GoogleAuthUseCase {
  final AuthRepository _authRepository;

  GoogleAuthUseCase(this._authRepository);

  Future<Either<Failure, UserCredential>> call() async {
    return await _authRepository.googleSignIn();
  }
}
