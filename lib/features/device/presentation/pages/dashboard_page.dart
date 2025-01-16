import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/device/presentation/bloc/device_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../utils/extensions/soil_humidity_extensions.dart';
import '../../../../utils/routes/routes.dart';
import '../widgets/average_quality_score.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  String formatDate(DateTime date) {
    final day = DateFormat('d').format(date);
    final suffix = getDaySuffix(int.parse(day));
    final month = DateFormat('MMMM').format(date);
    final year = DateFormat('y').format(date);
    return '$day$suffix $month $year';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceBloc, DeviceState>(
      builder: (context, state) {
        if (state is DeviceLoadedSuccess) {
          final device = state.device;
          if (device == null) {
            return const Center(
              child: Text("No device data available."),
            );
          }

          final lastDayData = device.getLatestDayMeasurements();
          lastDayData.sort((a, b) => b.time.compareTo(a.time));
          if (lastDayData.isEmpty) {
            return const Center(
              child: Text("No data available."),
            );
          }

          final sampleMoistureData =
              lastDayData.map((e) => e.moisture).toList();

          return Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              key: const Key("HomePage"),
              children: [
                AverageQualityScore(
                  score: sampleMoistureData.reduce((a, b) => a + b) /
                      sampleMoistureData.length,
                  grade: SoilHumidityGrade.moist.name,
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date: ${formatDate(lastDayData.first.date)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: lastDayData
                                .length, // Replace with actual article count
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text("Time ${lastDayData[index].time}"),
                                subtitle: Text(
                                    "Moisture ${lastDayData[index].moisture}%"),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            child: Text("Not yet pairing device"),
          );
        }
      },
    );
  }
}

class SignUpTestPage extends StatelessWidget {
  const SignUpTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                image: const AssetImage("assets/images/email_verify.png"),
                height: 200,
                width: 200,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    gapPadding: 4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    gapPadding: 4,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                obscureText: true,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    gapPadding: 4,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.visibility),
                    onPressed: () {},
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(AppRoute.initialRoute);
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
