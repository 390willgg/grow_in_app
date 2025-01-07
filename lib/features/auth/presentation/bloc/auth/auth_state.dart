part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class EmailIsSentState extends AuthState {}

class EmailIsVerifiedState extends AuthState {}

class SignedInState extends AuthState {}

class SignedInPageState extends AuthState {}

class VerifyEmailPageState extends AuthState {}

class LoggedOutState extends AuthState {}

class SignedUpState extends AuthState {}

class GoogleSignInState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
