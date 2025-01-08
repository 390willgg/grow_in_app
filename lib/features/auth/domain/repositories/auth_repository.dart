import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../error/failure.dart';
import '../../data/models/first_page/first_page.dart';
import '../entities/sign_in/sign_in.dart';
import '../entities/sign_up/sign_up.dart';

abstract class AuthRepository {
  FirstPageModel firstPage();

  Future<Either<Failure, UserCredential>> signIn(SignIn signInEntity);

  Future<Either<Failure, UserCredential>> signUp(SignUp signUpEntity);

  Future<Either<Failure, UserCredential>> googleSignIn();

  Future<Either<Failure, Unit>> verifyEmail();

  Future<Either<Failure, Unit>> checkEmailVerified(Completer completer);

  Future<Either<Failure, Unit>> logout();
}
