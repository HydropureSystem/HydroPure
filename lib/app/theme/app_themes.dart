import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF5F7FA),
    cardColor: Colors.white,
    primaryColor: Color(0xFF2E7D32),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF121212),
    cardColor: Color(0xFF1E1E1E),
    primaryColor: Color(0xFF66BB6A),
  );
}