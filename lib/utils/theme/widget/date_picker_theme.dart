import 'package:flutter/material.dart';

class AppDPT {
  AppDPT._();
  static final lightDPT = DatePickerThemeData(
    backgroundColor: Colors.green[50],
    headerBackgroundColor: Colors.green[200],
    dayStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
  );

  static final darkDPT = DatePickerThemeData(
    backgroundColor: Colors.black,
    headerBackgroundColor: Colors.green[700],
    dayStyle: TextStyle(
      color: Colors.white,
      fontSize: 14,
    ),
  );
}
