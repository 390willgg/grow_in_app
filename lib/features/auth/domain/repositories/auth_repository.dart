import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/error/failure.dart';
import '../../data/models/first_page/first_page_model.dart';
import '../entities/sign_in/sign_in.dart';
import '../entities/sign_up/sign_up.dart';
import '../entities/user/user.dart';

abstract class AuthRepository {
  Stream<Either<Failure, User?>> get user;

  Future<Either<Failure, UserEntity>> signUpTest(
    UserEntity user,
    String password,
  );

  Future<Either<Failure, Unit>> setUserData(UserEntity user);

  Future<Either<Failure, Unit>> signInTest(String email, String password);

  Future<Either<Failure, Unit>> logOutTest();

  FirstPageModel firstPage();

  Future<Either<Failure, UserCredential>> signIn(SignIn signInEntity);

  Future<Either<Failure, UserCredential>> signUp(SignUp signUpEntity);

  Future<Either<Failure, UserCredential>> googleSignIn();

  Future<Either<Failure, Unit>> verifyEmail();

  Future<Either<Failure, Unit>> checkEmailVerified(Completer completer);

  Future<Either<Failure, Unit>> logout();
}
