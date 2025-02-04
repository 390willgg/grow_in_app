import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grow_in_app/features/device/presentation/pages/home_page.dart';
import 'package:grow_in_app/features/profile/presentation/pages/login_page.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/signIn/sign_in_bloc.dart';
import '../../bloc/signUp/sign_up_bloc.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                labelColor: Theme.of(context).colorScheme.onSurface,
                tabs: const [
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(
                      logOutTestUseCase:
                          context.read<AuthenticationBloc>().logOutTestUseCase,
                      signInTestUseCase:
                          context.read<AuthenticationBloc>().signInTestUseCase,
                    ),
                    child: const LoginPage(),
                  ),
                  BlocProvider<SignUpBloc>(
                    create: (context) => SignUpBloc(
                      setUserDataUseCase:
                          context.read<AuthenticationBloc>().setUserDataUseCase,
                      signUpTestUseCase:
                          context.read<AuthenticationBloc>().signUpTestUseCase,
                    ),
                    child: const SignUpTestPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
