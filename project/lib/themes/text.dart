import 'package:flutter/material.dart';

TextTheme textTheme() {
  return const TextTheme(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
    displaySmall: TextStyle(
      color: Color(0xFF1D1B20),
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w600,
      height: 1.33,
      letterSpacing: 0.50,
    ),
  );
}
