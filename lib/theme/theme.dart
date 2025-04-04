import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade100,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade500,
    inversePrimary: Colors.grey.shade200,
    inverseSurface: Colors.grey.shade800,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade100,
    secondary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade200,
    inverseSurface: Colors.grey.shade200,
  ),
);
