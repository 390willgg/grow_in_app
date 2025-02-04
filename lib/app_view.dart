import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/auth/presentation/bloc/signIn/sign_in_bloc.dart';
import 'features/auth/presentation/bloc/signUp/sign_up_bloc.dart';
import 'features/auth/presentation/pages/welcome/welcome_screen.dart';
import 'features/device/presentation/bloc/device/device_bloc.dart';
import 'injection.dart' as di;
import 'main.dart';
import 'utils/routes/routes.dart';
import 'utils/theme/theme.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (_) => di.sl<AuthenticationBloc>(),
        ),
        BlocProvider<DeviceBloc>(
          create: (_) => di.sl<DeviceBloc>(),
        ),
        BlocProvider<SignInBloc>(
          create: (context) {
            final authBloc = context.read<AuthenticationBloc>();
            return SignInBloc(
              signInTestUseCase: authBloc.signInTestUseCase,
              logOutTestUseCase: authBloc.logOutTestUseCase,
            );
          },
        ),
        BlocProvider<SignUpBloc>(create: (context) {
          final authBloc = context.read<AuthenticationBloc>();
          return SignUpBloc(
            signUpTestUseCase: authBloc.signUpTestUseCase,
            setUserDataUseCase: authBloc.setUserDataUseCase,
          );
        })
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: router,
            builder: (context, child) {
              logger.i("${state.status}, ${child.toString()}");
              if (state.status == AuthenticationStatus.authenticated) {
                return child!;
              } else {
                return WelcomePage();
              }
            },
          );
        },
      ),
    );
  }
}
