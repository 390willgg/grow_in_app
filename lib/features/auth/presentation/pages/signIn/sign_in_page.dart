import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../widgets/auth/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Image(
              height: 200,
              width: 200,
              image: AssetImage(signInImage),
            ),
          ),
          Center(
            child: Text(
              "Login",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SignInForm()
        ],
      ),
    ));
  }
}
