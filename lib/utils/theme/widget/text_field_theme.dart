import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class AppTFFT {
  AppTFFT._();

  static InputDecorationTheme lightIDT = const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: secondaryColor,
    floatingLabelStyle: TextStyle(color: secondaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: secondaryColor),
    ),
  );

  static InputDecorationTheme darkIDT = const InputDecorationTheme(
    border: OutlineInputBorder(),
    prefixIconColor: primaryColor,
    floatingLabelStyle: TextStyle(color: primaryColor),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: primaryColor),
    ),
  );
}
