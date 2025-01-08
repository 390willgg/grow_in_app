import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grow_in_app/error/exceptions.dart';

import '../../../../error/failure.dart';
import '../../domain/entities/sign_in/sign_in.dart';
import '../../domain/entities/sign_up/sign_up.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_datasources.dart';
import '../models/first_page/first_page.dart';
import '../models/sign_in/sign_in_model.dart';
import '../models/sign_up/sign_up_model.dart';

class AuthenticationRepositoryImplementation extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImplementation({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Unit>> checkEmailVerified(Completer completer) async {
    try {
      await waitForVerifiedUser(completer).timeout(const Duration(days: 30));
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<void> waitForVerifiedUser(Completer completer) async {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        FirebaseAuth.instance.currentUser?.reload();
        if (FirebaseAuth.instance.currentUser!.emailVerified) {
          completer.complete();
          timer.cancel();
        }
      },
    );
    await completer.future;
  }

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final userCredential = await remoteDataSource.googleAuthentication();
        return Right(userCredential);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();
        return Right(unit);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signIn(SignIn signInEntity) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        final signIn = SignInModel(
            email: signInEntity.email, password: signInEntity.password);
        final userCredential = await remoteDataSource.signIn(signIn);
        return Right(userCredential);
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on WrongPasswordException {
        return Left(WeakPasswordFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUp(SignUp signUpEntity) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!(connectivityResult != ConnectivityResult.none)) {
      return Left(OfflineFailure());
    } else if (signUpEntity.password != signUpEntity.repeatPassword) {
      return Left(UnmatchedPasswordFailure());
    } else {
      try {
        final signUp = SignUpModel(
          email: signUpEntity.email,
          password: signUpEntity.password,
          name: signUpEntity.name,
          repeatPassword: signUpEntity.repeatPassword,
        );
        final userCredential = await remoteDataSource.signUp(signUp);
        return Right(userCredential);
      } on WeakPasswordException {
        return Left(WeakPasswordFailure());
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        await remoteDataSource.verifyEmail();
        return const Right(unit);
      } on TooManyRequestException {
        return Left(TooManyRequestsFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on NoUserException {
        return Left(NoUserFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  FirstPageModel firstPage() {
    final userCredential = FirebaseAuth.instance.currentUser;
    if (userCredential != null && userCredential.emailVerified) {
      return const FirstPageModel(isLoggedIn: true, isEmailVerified: false);
    } else if (userCredential != null) {
      return const FirstPageModel(isLoggedIn: false, isEmailVerified: true);
    } else {
      return const FirstPageModel(isLoggedIn: false, isEmailVerified: false);
    }
  }
}
