import 'package:flutter/material.dart';

extension ElevatedButtonExtensions on ElevatedButton {
  static ElevatedButton styled({
    required VoidCallback onPressed,
    required Widget child,
    Color? color,
    double borderRadius = 8.0,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: child,
    );
  }
}
