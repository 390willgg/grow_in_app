part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

final class SignInRequiredEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInRequiredEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

final class SignOutEvent extends SignInEvent {}
