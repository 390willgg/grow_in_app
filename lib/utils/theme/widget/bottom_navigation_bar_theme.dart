import 'package:flutter/material.dart';

class AppBNBT {
  AppBNBT._();

  static final lightBNBT = BottomNavigationBarThemeData(
    backgroundColor: Colors.green[50],
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black54,
  );

  static final darkBNBT = BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.green[700],
    unselectedItemColor: Colors.white60,
  );
}
