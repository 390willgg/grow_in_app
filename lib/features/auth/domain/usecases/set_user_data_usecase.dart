import 'package:dartz/dartz.dart';
import 'package:grow_in_app/features/auth/domain/entities/user/user.dart';

import '../../../../utils/error/failure.dart';
import '../repositories/auth_repository.dart';

class SetUserDataUseCase {
  final AuthRepository repository;

  SetUserDataUseCase(this.repository);

  Future<Either<Failure, Unit>> call(UserEntity user) async {
    return await repository.setUserData(user);
  }
}
