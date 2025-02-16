import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../main.dart';
import '../../../../../utils/common/helpers/strings_helper.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/sign_in_usecase.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInTestUseCase;
  final LogOutUseCase logOutTestUseCase;

  SignInBloc({
    required this.signInTestUseCase,
    required this.logOutTestUseCase,
  }) : super(SignInInitial()) {
    on<SignInRequiredEvent>(
      (event, emit) async {
        emit(SignInLoading());
        try {
          final result = await signInTestUseCase(
            event.email,
            event.password,
          );

          result.fold(
            (failure) {
              logger.i("Failure area signIn: $failure");
              emit(SignInFailure(
                message: StringsHelper.mapFailureToMessage(failure),
              ));
            },
            (_) => emit(SignInSuccess()),
          );
        } catch (e) {
          logger.e("Error area signIn: $e");
          emit(SignInFailure(message: e.toString()));
        }
      },
    );

    on<SignOutEvent>(
      (event, emit) async {
        emit(SignInLoading());
        try {
          final result = await logOutTestUseCase();
          result.fold(
            (failure) async => emit(SignOutFailure(
              message: StringsHelper.mapFailureToMessage(failure),
            )),
            (_) async => emit(SignOutSuccess()),
          );
        } catch (e) {
          emit(const SignOutFailure());
        }
      },
    );
  }
}
