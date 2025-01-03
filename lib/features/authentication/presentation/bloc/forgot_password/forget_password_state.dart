part of 'forget_password_bloc.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();
}

final class ForgetPasswordInitial extends ForgetPasswordState {
  @override
  List<Object> get props => [];
}
