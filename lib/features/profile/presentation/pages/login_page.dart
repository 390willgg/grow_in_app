import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/common/helpers/strings_helper.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/extensions/text_field_extensions.dart';
import '../../../../utils/routes/routes.dart';
import '../../../auth/presentation/bloc/signIn/sign_in_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  String? errorMsg;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome back"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 16.0,
          children: [
            BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignInLoading) {
                  setState(() {
                    signInRequired = true;
                  });
                }
                if (state is SignInSuccess) {
                  setState(() {
                    signInRequired = false;
                  });
                }
                if (state is SignInFailure) {
                  setState(() {
                    signInRequired = false;
                    errorMsg = state.message;
                  });
                }
              },
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 16.0,
                  verticalDirection: VerticalDirection.down,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      height: 200,
                      width: 200,
                      image: const AssetImage(signInImage),
                    ),
                    TextFieldExtensions(
                      controller: emailController,
                      hintText: eMail,
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(CupertinoIcons.mail_solid),
                      errorMsg: errorMsg,
                      validator: StringsHelper.checkFormatEmail,
                    ),
                    TextFieldExtensions(
                      controller: passwordController,
                      hintText: ePassword,
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      errorMsg: errorMsg,
                      validator: StringsHelper.checkPasswordFormat,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              obscurePassword = !obscurePassword;
                              iconPassword = obscurePassword
                                  ? CupertinoIcons.eye_fill
                                  : CupertinoIcons.eye_slash_fill;
                            },
                          );
                        },
                        icon: Icon(iconPassword),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(
                                  SignInRequiredEvent(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                          }
                        },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        child: const Text(login),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // BlocProvider<SignUpBloc>(
            //   create: (context) => SignUpBloc(
            //     signUpTestUseCase:
            //         context.read<AuthenticationBloc>().signUpTestUseCase,
            //     setUserDataUseCase:
            //         context.read<AuthenticationBloc>().setUserDataUseCase,
            //   ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                children: [
                  TextSpan(
                    text: signUp,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        GoRouter.of(context).go(AppRoute.initialRoute);
                      },
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}
