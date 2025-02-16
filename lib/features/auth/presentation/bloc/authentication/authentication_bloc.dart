import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../main.dart';
import '../../../../../utils/error/failure.dart';
import '../../../domain/usecases/get_user_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/set_user_data_usecase.dart';
import '../../../domain/usecases/sign_in_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetUser getUser;
  final SignUpUseCase signUpTestUseCase;
  final SetUserDataUseCase setUserDataUseCase;
  final SignInUseCase signInTestUseCase;
  final LogOutUseCase logOutTestUseCase;

  late final StreamSubscription<Either<Failure, User?>> userSubscription;

  AuthenticationBloc({
    required this.signUpTestUseCase,
    required this.setUserDataUseCase,
    required this.signInTestUseCase,
    required this.logOutTestUseCase,
    required this.getUser,
  }) : super(const AuthenticationState.unknown()) {
    userSubscription = getUser().listen(
      (result) {
        result.fold(
          (failure) {
            logger.i(failure);
            add(const AuthenticationUserChangedEvent(null));
          },
          (user) {
            logger.i(user);
            add(AuthenticationUserChangedEvent(user));
          },
        );
      },
    );

    on<AuthenticationUserChangedEvent>(
      (event, emit) {
        if (event.user != null) {
          emit(AuthenticationState.authenticated(event.user!));
        } else {
          emit(const AuthenticationState.unauthenticated());
        }
      },
    );
  }

  @override
  Future<void> close() {
    userSubscription.cancel();
    return super.close();
  }
}
