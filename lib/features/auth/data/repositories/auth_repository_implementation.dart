import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../main.dart';
import '../../../../utils/common/helpers/network_helper.dart';
import '../../../../utils/error/exceptions.dart';
import '../../../../utils/error/failure.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote_datasources.dart';
import '../models/user/user_model.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImplementation({
    required this.remoteDataSource,
  });

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
