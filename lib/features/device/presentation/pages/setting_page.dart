import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_in_app/features/device/presentation/bloc/device/device_bloc.dart'
    show DeviceBloc, DeviceLoadedSuccess, DeviceState;
import 'package:grow_in_app/utils/routes/routes.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../auth/presentation/bloc/signIn/sign_in_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
        key: const Key(settingsKey),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BlocBuilder<DeviceBloc, DeviceState>(
              builder: (context, state) {
                return ListTile(
                  leading: const Icon(Icons.opacity_outlined),
                  title: const Text("Soil Moisture"),
                  subtitle: const Text("Set the soil moisture level"),
                  onTap: state is DeviceLoadedSuccess
                      ? () {
                          context.push(AppRoute.settingSoilMoistureDeviceRoute);
                        }
                      : null,
                  enabled: state is DeviceLoadedSuccess,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(aboutTitle),
              subtitle: const Text(aboutSubTitle),
              onTap: () {
                context.push(AppRoute.aboutRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(logOutTitle),
              subtitle: const Text(logOutSubTitle),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text(logOutTitle),
                      content: const Text(logOutMessage),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text(cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<SignInBloc>().add(SignOutEvent());
                          },
                          child: const Text(logOutTitle),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
