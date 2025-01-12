import 'package:flutter/material.dart';

import 'widget/elevated_button_theme.dart';
import 'widget/outlined_button_theme.dart';
import 'widget/text_field_theme.dart';
import 'widget/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: AppTextTheme.lightTextTheme,
    primaryColor: Colors.green[200],
    scaffoldBackgroundColor: Colors.green[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green[200],
      foregroundColor: Colors.black87,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.green[50],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black54,
    ),
    outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[200],
      foregroundColor: Colors.white,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.green[50],
      headerBackgroundColor: Colors.green[200],
      dayStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: Colors.green[700],
      unselectedItemColor: Colors.white60,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white70,
    ),
    textTheme: AppTextTheme.darkTextTheme,
    outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.green[100],
      ),
      contentTextStyle: TextStyle(
        color: Colors.green[200],
      ),
    ),
  );
}
