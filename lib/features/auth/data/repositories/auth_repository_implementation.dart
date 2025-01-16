import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../main.dart';
import '../../../../utils/common/helpers/network_helper.dart';
import '../../../../utils/error/exceptions.dart';
import '../../../../utils/error/failure.dart';
import '../../domain/entities/sign_in/sign_in.dart';
import '../../domain/entities/sign_up/sign_up.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_datasources.dart';
import '../models/first_page/first_page_model.dart';
import '../models/sign_in/sign_in_model.dart';
import '../models/sign_up/sign_up_model.dart';
import '../models/user/user_model.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImplementation({
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
    bool isConnected = await NetworkHelper.isConnected();
    if (isConnected) {
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
    bool isConnected = await NetworkHelper.isConnected();
    if (isConnected) {
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
    bool isConnected = await NetworkHelper.isConnected();

    if (isConnected) {
      try {
        final signIn = SignInModel(
          email: signInEntity.email,
          password: signInEntity.password,
        );

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
    bool isConnected = await NetworkHelper.isConnected();
    if (!(isConnected)) {
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
    bool isConnected = await NetworkHelper.isConnected();

    if (isConnected) {
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

  @override
  Future<Either<Failure, Unit>> logOutTest() async {
    bool isConnected = await NetworkHelper.isConnected();
    if (isConnected) {
      try {
        await remoteDataSource.logOutTest();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signInTest(
    String email,
    String password,
  ) async {
    bool isConnected = await NetworkHelper.isConnected();
    if (isConnected) {
      try {
        await remoteDataSource.signInTest(email, password);
        return Right(unit);
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
  Stream<Either<Failure, User?>> get user {
    return remoteDataSource.user.map(
      (user) {
        if (user != null) {
          return Right(user);
        } else {
          return Left(NoUserFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> setUserData(UserEntity user) async {
    bool isConnected = await NetworkHelper.isConnected();
    if (isConnected) {
      try {
        logger.i('setUserData: $user');
        await remoteDataSource.setUserData(
          UserModel(
            id: user.id,
            email: user.email,
            name: user.name,
            deviceId: user.deviceId,
          ),
        );
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpTest(
    UserEntity user,
    String password,
  ) async {
    bool isConnected = await NetworkHelper.isConnected();
    if (isConnected) {
      try {
        final myUser = UserModel(
          id: user.id,
          email: user.email,
          name: user.name,
          deviceId: user.deviceId,
        );
        final result = await remoteDataSource.signUpTest(myUser, password);
        return Right(result);
      } on WeakPasswordException {
        return Left(WeakPasswordFailure());
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
