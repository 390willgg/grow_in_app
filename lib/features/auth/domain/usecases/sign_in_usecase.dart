import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grow_in_app/error/failure.dart';
import 'package:grow_in_app/features/auth/domain/entities/sign_in/sign_in.dart';
import 'package:grow_in_app/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, UserCredential>> call(SignInEntity signIn) async {
    return await repository.signIn(signIn);
  }
}
