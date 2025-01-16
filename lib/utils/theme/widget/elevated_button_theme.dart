import 'package:flutter/material.dart';

import '../../constants/sizes.dart';

class AppEBT {
  AppEBT._();

  static final lightEBT = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      backgroundColor: Colors.green[300],
      padding: const EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );

  static final darkEBT = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: const RoundedRectangleBorder(),
      foregroundColor: Colors.green[300],
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: buttonHeight,
      ),
    ),
  );
}
