part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class CheckLogInEvent extends AuthEvent {}

final class CheckEmailVerificationEvent extends AuthEvent {}

final class SendEmailVerificationEvent extends AuthEvent {}

final class SignInWithGoogleEvent extends AuthEvent {}

final class LogOutEvent extends AuthEvent {}

final class SignInEvent extends AuthEvent {
  final SignIn signInEntity;

  const SignInEvent({required this.signInEntity});

  @override
  List<Object> get props => [signInEntity];
}

final class SignUpEvent extends AuthEvent {
  final SignUp signUpEntity;

  const SignUpEvent({required this.signUpEntity});

  @override
  List<Object> get props => [signUpEntity];
}
