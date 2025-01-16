import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_in_app/features/device/presentation/bloc/device_bloc.dart';

import 'features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'features/auth/presentation/bloc/signIn/sign_in_bloc.dart';
import 'features/auth/presentation/pages/welcome/welcome_screen.dart';
import 'injection.dart' as di;
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
        BlocProvider<DeviceBloc>(create: (_) => di.sl<DeviceBloc>()),
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(
            signInTestUseCase:
                context.read<AuthenticationBloc>().signInTestUseCase,
            logOutTestUseCase:
                context.read<AuthenticationBloc>().logOutTestUseCase,
          ),
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'flutter demo',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: router,
            builder: (context, child) {
              if (state.status == AuthenticationStatus.authenticated) {
                return child!;
              } else {
                return const WelcomeScreen();
              }
            },
          );
        },
      ),
    );
  }
}
