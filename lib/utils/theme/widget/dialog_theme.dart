import 'package:flutter/material.dart';

class AppDT {
  AppDT._();
  static final lightDT = DialogTheme(
    backgroundColor: Colors.green[50],
    titleTextStyle: TextStyle(
      color: Colors.green[700],
    ),
    contentTextStyle: TextStyle(
      color: Colors.green[900],
    ),
  );
  static final darkDT = DialogTheme(
    backgroundColor: Colors.black,
    titleTextStyle: TextStyle(
      color: Colors.green[100],
    ),
    contentTextStyle: TextStyle(
      color: Colors.green[200],
    ),
  );
}
