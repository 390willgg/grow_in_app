import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_view.dart';
import 'features/auth/domain/usecases/get_user_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/set_user_data_usecase.dart';
import 'features/auth/domain/usecases/sign_in_usecase.dart';
import 'features/auth/domain/usecases/sign_up_usecase.dart';
import 'features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'injection.dart' as di;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(
          signUpTestUseCase: di.sl<SignUpUseCase>(),
          setUserDataUseCase: di.sl<SetUserDataUseCase>(),
          getUser: di.sl<GetUser>(),
          signInTestUseCase: di.sl<SignInUseCase>(),
          logOutTestUseCase: di.sl<LogOutUseCase>(),
        );
      },
      child: const AppView(),
    );
  }
}
