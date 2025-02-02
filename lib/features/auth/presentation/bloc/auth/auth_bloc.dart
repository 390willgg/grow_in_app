import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../utils/common/helpers/strings_helper.dart';
import '../../../domain/entities/sign_in/sign_in.dart';
import '../../../domain/entities/sign_up/sign_up.dart';
import '../../../domain/usecases/check_verification_usecase.dart';
import '../../../domain/usecases/first_page_usecase.dart';
import '../../../domain/usecases/google_auth_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/sign_in_usecase.dart';
import '../../../domain/usecases/sign_up_usecase.dart';
import '../../../domain/usecases/verify_email_usecase.dart';

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

  Completer<Unit> completer = Completer<Unit>();

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
          completer = Completer<Unit>();
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
      (l) => AuthErrorState(message: StringsHelper.mapFailureToMessage(l)),
      (_) => state,
    );
  }
}
