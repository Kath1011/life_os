import 'package:flutter/material.dart';

final ThemeData emergencyTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF300106),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFF3C45),
    secondary: Color(0xFFFFA2A7),
    surface: Color(0xFF4B0A12),
  ),
  useMaterial3: true,
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.w800),
  ),
);
