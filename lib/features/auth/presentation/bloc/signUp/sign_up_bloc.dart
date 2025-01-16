import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grow_in_app/main.dart';

import '../../../../../utils/common/helpers/strings_helper.dart';
import '../../../data/models/user/user_model.dart';
import '../../../domain/usecases/set_user_data_usecase.dart';
import '../../../domain/usecases/sign_up_test_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpTestUseCase signUpTestUseCase;
  final SetUserDataUseCase setUserDataUseCase;

  SignUpBloc({
    required this.signUpTestUseCase,
    required this.setUserDataUseCase,
  }) : super(SignUpInitial()) {
    on<SignUpRequiredEvent>(
      (event, emit) async {
        emit(SignUpLoading());
        try {
          final result = await signUpTestUseCase.call(
            event.user,
            event.password,
          );
          await result.fold(
            (failure) async => {
              logger.i("Failure area signUp: $failure"),
              emit(SignUpFailure(
                message: StringsHelper.mapFailureToMessage(failure),
              ))
            },
            (user) async {
              final resultData = await setUserDataUseCase.call(user);
              await resultData.fold(
                (failure) async {
                  logger.e("Failure area signUp: $failure");
                  emit(SignUpFailure(
                    message: StringsHelper.mapFailureToMessage(failure),
                  ));
                },
                (_) async => emit(SignUpSuccess()),
              );
            },
          );
        } catch (e) {
          logger.e(e.toString());
          emit(SignUpFailure(message: e.toString()));
        }
      },
    );
  }
}
