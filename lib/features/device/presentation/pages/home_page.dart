import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/auth/data/models/user/user_model.dart';
import 'package:grow_in_app/features/auth/presentation/bloc/signUp/sign_up_bloc.dart';
import 'package:grow_in_app/utils/common/helpers/strings_helper.dart';
import 'package:grow_in_app/utils/extensions/text_field_extensions.dart';

import '../../../../utils/common/helpers/date_helper.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/extensions/soil_humidity_extensions.dart';
import '../../../../utils/routes/routes.dart';
import '../../../auth/presentation/bloc/authentication/authentication_bloc.dart';
import '../../../auth/presentation/bloc/signIn/sign_in_bloc.dart';
import '../bloc/device/device_bloc.dart';
import '../widgets/average_quality_score.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        if (state is DeviceLoadedSuccess) {
          final device = state.device;
          if (device == null) {
            return const Center(
              child: Text(noDeviceFound),
            );
          }

          final lastDayData = device.getLatestDayMeasurements();
          lastDayData.sort((a, b) => a.time.compareTo(b.time));

          if (lastDayData.isEmpty) {
            return const Center(
              child: Text(noDataAvailable),
            );
          }

          final sampleMoistureData =
              lastDayData.map((e) => e.moisture).toList();
          final averageMoisture = sampleMoistureData.reduce((a, b) => a + b) /
              sampleMoistureData.length;

          return Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              key: const Key(homeTitle),
              children: [
                AverageQualityScore(
                  score: averageMoisture,
                  grade: SoilHumidityGradeExtension.fromAverageMoisture(
                    averageMoisture,
                  ),
                ),
                Expanded(
                  child: Container(
                    key: const Key("lastDayData"),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    child: Column(
                      key: const Key("lastDayDataColumn"),
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      verticalDirection: VerticalDirection.down,
                      textBaseline: TextBaseline.alphabetic,
                      textDirection: TextDirection.ltr,
                      children: [
                        Text(
                          "Date: ${DateHelper.formatDate(lastDayData.first.date)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          key: const Key("date"),
                          maxLines: 1,
                        ),
                        Flexible(
                          child: ListView.builder(
                            shrinkWrap: true,
                            key: const Key("lastDayDataListView"),
                            itemCount: lastDayData
                                .length, // Replace with actual article count
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  "Time ${lastDayData[index].time}",
                                ),
                                subtitle: Text(
                                  "Moisture ${lastDayData[index].moisture.toInt()}%",
                                ),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is DeviceLoadedFailure) {
          return Center(
            child: Text(
              state.message.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(
            child: Text(deviceNotYetPairing),
          );
        }
      },
    );
  }
}

class SignUpTestPage extends StatefulWidget {
  const SignUpTestPage({super.key});

  @override
  State<SignUpTestPage> createState() => _SignUpTestPageState();
}

class _SignUpTestPageState extends State<SignUpTestPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  IconData iconPassword = CupertinoIcons.eye_fill;
  String? errorMsg;

  bool signUpRequired = false;

  final _formKey = GlobalKey<FormState>();

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(signUp),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state is SignUpSuccess) {
                setState(() {
                  signUpRequired = false;
                });
              } else if (state is SignUpLoading) {
                setState(() {
                  signUpRequired = true;
                });
              } else if (state is SignUpFailure) {
                setState(() {
                  signUpRequired = false;
                  errorMsg = state.message;
                });
                return;
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    height: 200,
                    width: 200,
                    image: const AssetImage(emailVerifyImage),
                  ),
                  TextFieldExtensions(
                    controller: emailController,
                    hintText: eMail,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail),
                    errorMsg: errorMsg,
                    validator: StringsHelper.checkFormatEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFieldExtensions(
                    controller: passwordController,
                    hintText: ePassword,
                    obscureText: obscurePassword,
                    errorMsg: errorMsg,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    suffixIcon: IconButton(
                      icon: Icon(iconPassword),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                          iconPassword = obscurePassword
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill;
                        });
                      },
                    ),
                    validator: StringsHelper.checkPasswordFormat,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 uppercase",
                            style: TextStyle(
                              color: containsUpperCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "⚈  1 lowercase",
                            style: TextStyle(
                              color: containsLowerCase
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "⚈  1 number",
                            style: TextStyle(
                              color: containsNumber
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  1 special character",
                            style: TextStyle(
                              color: containsSpecialChar
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            "⚈  8 minimum character",
                            style: TextStyle(
                              color: contains8Length
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFieldExtensions(
                    controller: confirmPasswordController,
                    hintText: eConfirmPassword,
                    errorMsg: errorMsg,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureConfirmPassword,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    suffixIcon: IconButton(
                      icon: Icon(iconPassword),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                          iconPassword = obscureConfirmPassword
                              ? CupertinoIcons.eye_fill
                              : CupertinoIcons.eye_slash_fill;
                        });
                      },
                    ),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter your confirm password";
                      } else if (val != passwordController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  !signUpRequired
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                UserModel user =
                                    UserModel(id: "", email: '', name: '');
                                user = user.copyWith(
                                    email: emailController.text, name: '');
                                setState(() {
                                  context.read<SignUpBloc>().add(
                                      SignUpRequiredEvent(
                                          user, passwordController.text));
                                });
                              }
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            child: const Text(signUp),
                          ),
                        )
                      : const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(
                      logOutTestUseCase:
                          context.read<AuthenticationBloc>().logOutTestUseCase,
                      signInTestUseCase:
                          context.read<AuthenticationBloc>().signInTestUseCase,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: alreadyHaveAnAccount,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: login,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(AppRoute.loginRoute);
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? checkFormatPassword(val) {
    if (val!.contains(RegExp(r'[A-Z]'))) {
      setState(() {
        containsUpperCase = true;
      });
    } else {
      setState(() {
        containsUpperCase = false;
      });
    }
    if (val.contains(RegExp(r'[a-z]'))) {
      setState(() {
        containsLowerCase = true;
      });
    } else {
      setState(() {
        containsLowerCase = false;
      });
    }
    if (val.contains(RegExp(r'[0-9]'))) {
      setState(() {
        containsNumber = true;
      });
    } else {
      setState(() {
        containsNumber = false;
      });
    }
    if (val.contains(RegExp(r'^(?=.*?[!@#$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
      setState(() {
        containsSpecialChar = true;
      });
    } else {
      setState(() {
        containsSpecialChar = false;
      });
    }
    if (val.length >= 8) {
      setState(() {
        contains8Length = true;
      });
    } else {
      setState(() {
        contains8Length = false;
      });
    }
    return null;
  }
}
