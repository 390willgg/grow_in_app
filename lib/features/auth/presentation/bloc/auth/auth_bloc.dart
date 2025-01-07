import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:grow_in_app/error/failure.dart';
import 'package:grow_in_app/features/auth/domain/entities/sign_in/sign_in.dart';
import 'package:grow_in_app/features/auth/domain/usecases/check_verification_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/first_page_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/google_auth_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/verifiy_email_usecase.dart';

import '../../../../../constants/image_strings.dart';
import '../../../domain/entities/sign_up/sign_up.dart';
import '../../../domain/usecases/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCse;
  final SignUpUseCase signUpUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final FirstPageUseCase firstPageUseCase;
  final CheckVerificationUseCase checkVerificationUseCase;
  final LogOutUseCase logOutUseCase;
  final GoogleAuthUseCase googleAuthUseCase;

  Completer<Void> completer = Completer<Void>();

  AuthBloc({
    required this.signInUseCse,
    required this.signUpUseCase,
    required this.verifyEmailUseCase,
    required this.firstPageUseCase,
    required this.checkVerificationUseCase,
    required this.logOutUseCase,
    required this.googleAuthUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is CheckLogInEvent) {
        final firstPage = firstPageUseCase();
        if (firstPage.isLoggedIn) {
          emit(SignedInPageState());
        } else if (firstPage.isEmailVerified) {
          emit(VerifyEmailPageState());
        }
      } else if (event is SignInEvent) {
        emit(AuthLoadingState());
        final result = await signInUseCse(event.signInEntity);
        emit(eitherToState(result, SignedInState()));
      } else if (event is SignUpEvent) {
        emit(AuthLoadingState());
        final result = await signUpUseCase(event.signUpEntity);
        emit(eitherToState(result, VerifyEmailPageState()));
      } else if (event is SendEmailVerificationEvent) {
        final result = await verifyEmailUseCase();
        emit(eitherToState(result, VerifyEmailPageState()));
      } else if (event is CheckEmailVerificationEvent) {
        if (!completer.isCompleted) {
          completer.complete();
          completer = Completer<Void>();
        }
        final result = await checkVerificationUseCase(completer);
        emit(eitherToState(result, EmailIsVerifiedState()));
      } else if (event is LogOutEvent) {
        final result = await logOutUseCase();
        emit(eitherToState(result, LoggedOutState()));
      } else if (event is SignInWithGoogleEvent) {
        emit(AuthLoadingState());
        final result = await googleAuthUseCase();
        emit(eitherToState(result, GoogleSignInState()));
      }
    });
  }

  AuthState eitherToState(Either either, AuthState state) {
    return either.fold(
      (l) => AuthErrorState(message: _mapFailureToMessage(l)),
      (_) => state,
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailure;
      case const (OfflineFailure):
        return offlineFailure;
      case const (WeakPasswordFailure):
        return weakPassword;
      case const (ExistedAccountFailure):
        return existedAccount;
      case const (NoUserFailure):
        return noUser;
      case const (TooManyRequestsFailure):
        return tooManyRequests;
      case const (WrongPasswordFailure):
        return wrongPassword;
      case const (UnmatchedPasswordFailure):
        return unmatchedPassword;
      case const (NotLoggedInFailure):
        return '';
      default:
        return 'Unexpected Error';
    }
  }
}
