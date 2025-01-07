import 'package:flutter/material.dart';

import '../widgets/auth/sign_up_form.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Image(
                  height: 200,
                  width: 200,
                  image: AssetImage("assets/sign_in.png")),
            ),
            Center(
                child: Text(
              "Signup",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
