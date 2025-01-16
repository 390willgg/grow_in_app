import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grow_in_app/utils/error/failure.dart';

import '../repositories/auth_repository.dart';

class GetUserTest {
  final AuthRepository repository;

  GetUserTest(this.repository);

  Stream<Either<Failure, User?>> call() {
    return repository.user;
  }
}
