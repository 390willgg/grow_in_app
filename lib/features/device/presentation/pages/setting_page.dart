import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../auth/presentation/bloc/signIn/sign_in_bloc.dart';
import 'about_page.dart';

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
            ListTile(
              leading: Icon(Icons.info),
              title: Text(aboutTitle),
              subtitle: Text(aboutSubTitle),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text(logOutTitle),
              subtitle: Text(logOutSubTitle),
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
