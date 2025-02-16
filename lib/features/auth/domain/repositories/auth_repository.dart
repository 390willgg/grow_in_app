import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/error/failure.dart';
import '../entities/user/user.dart';

abstract class AuthRepository {
  Stream<Either<Failure, User?>> get user;

  Future<Either<Failure, UserEntity>> signUpTest(
    UserEntity user,
    String password,
  );

  Future<Either<Failure, Unit>> setUserData(UserEntity user);

  Future<Either<Failure, Unit>> signInTest(
    String email,
    String password,
  );

  Future<Either<Failure, Unit>> logOutTest();
}
