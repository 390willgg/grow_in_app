part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

final class SignInSuccess extends SignInState {}

final class SignInFailure extends SignInState {
  final String? message;

  const SignInFailure({this.message});
}

final class SignInLoading extends SignInState {}

final class SignOutInitial extends SignInState {}

final class SignOutLoading extends SignInState {}

final class SignOutSuccess extends SignInState {}

final class SignOutFailure extends SignInState {
  final String? message;

  const SignOutFailure({this.message});
}