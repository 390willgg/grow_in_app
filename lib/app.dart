import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_in_app/app_view.dart';
import 'package:grow_in_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/logout_test_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/sign_in_test_usecase.dart';
import 'package:grow_in_app/features/auth/domain/usecases/sign_up_test_usecase.dart';
import 'package:grow_in_app/features/auth/presentation/bloc/authentication/authentication_bloc.dart';

import 'features/auth/domain/usecases/set_user_data_usecase.dart';
import 'injection.dart' as di;

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(
          signUpTestUseCase: di.sl<SignUpTestUseCase>(),
          setUserDataUseCase: di.sl<SetUserDataUseCase>(),
          getUser: di.sl<GetUserTest>(),
          signInTestUseCase: di.sl<SignInTestUseCase>(),
          logOutTestUseCase: di.sl<LogOutTestUseCase>(),
        );
      },
      child: const AppView(),
    );
  }
}
