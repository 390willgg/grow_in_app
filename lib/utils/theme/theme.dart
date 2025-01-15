import 'package:flutter/material.dart';
import 'package:grow_in_app/utils/theme/widget/app_bar_theme.dart';
import 'package:grow_in_app/utils/theme/widget/bottom_navigation_bar_theme.dart';
import 'package:grow_in_app/utils/theme/widget/dialog_theme.dart';
import 'package:grow_in_app/utils/theme/widget/floating_action_button_theme.dart';

import 'widget/date_picker_theme.dart';
import 'widget/elevated_button_theme.dart';
import 'widget/outlined_button_theme.dart';
import 'widget/text_field_theme.dart';
import 'widget/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: AppTT.lightTT,
    primaryColor: Colors.green[200],
    scaffoldBackgroundColor: Colors.green[50],
    appBarTheme: AppBT.lightABT,
    bottomNavigationBarTheme: AppBNBT.lightBNBT,
    outlinedButtonTheme: AppOBT.lightOBT,
    elevatedButtonTheme: AppEBT.lightEBT,
    inputDecorationTheme: AppTFFT.lightIDT,
    floatingActionButtonTheme: AppFABT.lightFABT,
    datePickerTheme: AppDPT.lightDPT,
    dialogTheme: AppDT.lightDT,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: Colors.green[700],
    scaffoldBackgroundColor: Colors.black,
    bottomNavigationBarTheme: AppBNBT.darkBNBT,
    appBarTheme: AppBT.darkABT,
    textTheme: AppTT.darkTT,
    outlinedButtonTheme: AppOBT.darkOBT,
    elevatedButtonTheme: AppEBT.darkEBT,
    inputDecorationTheme: AppTFFT.darkIDT,
    datePickerTheme: AppDPT.darkDPT,
    floatingActionButtonTheme: AppFABT.darkFABT,
    dialogTheme: AppDT.darkDT,
  );
}
