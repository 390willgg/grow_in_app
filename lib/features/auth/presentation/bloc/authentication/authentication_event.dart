part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationUserChangedEvent extends AuthenticationEvent {
  final User? user;

  const AuthenticationUserChangedEvent(this.user);

  @override
  List<Object?> get props => [user];
}
