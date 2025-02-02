import 'package:dartz/dartz.dart';
import 'package:grow_in_app/features/auth/domain/repositories/auth_repository.dart';

import '../../../../utils/error/failure.dart';

class VerifyEmailUseCase {
  final AuthRepository repository;

  VerifyEmailUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async => await repository.verifyEmail();
}
