import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTT {
  AppTT._();

  static TextTheme lightTT = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
      color: Colors.black87,
    ),
    labelMedium: GoogleFonts.poppins(
      color: Colors.black54,
      fontSize: 24,
    ),
    bodySmall: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  );

  static TextTheme darkTT = TextTheme(
    headlineMedium: GoogleFonts.montserrat(
      color: Colors.white70,
    ),
    labelMedium: GoogleFonts.poppins(
      color: Colors.white60,
      fontSize: 24,
    ),
    bodySmall: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  );
}
