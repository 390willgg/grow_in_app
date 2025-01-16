part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequiredEvent extends SignUpEvent {
  final UserModel user;
  final String password;

  const SignUpRequiredEvent(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}
