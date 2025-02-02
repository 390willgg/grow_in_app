import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {}

class ServerFailure extends Failure {}

class WeakPasswordFailure extends Failure {}

class ExistedAccountFailure extends Failure {}

class NoUserFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class UnmatchedPasswordFailure extends Failure {}

class NotLoggedInFailure extends Failure {}

class EmailVerifiedFailure extends Failure {}

class TooManyRequestsFailure extends Failure {}
