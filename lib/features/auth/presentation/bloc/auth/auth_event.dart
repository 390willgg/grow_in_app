part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckLogInEvent extends AuthEvent {}

class CheckEmailVerificationEvent extends AuthEvent {}

class SendEmailVerificationEvent extends AuthEvent {}

class SignInWithGoogleEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final SignInEntity signInEntity;

  const SignInEvent({required this.signInEntity});

  @override
  List<Object> get props => [signInEntity];
}

class SignUpEvent extends AuthEvent {
  final SignUpEntity signUpEntity;

  const SignUpEvent({required this.signUpEntity});

  @override
  List<Object> get props => [signUpEntity];
}
