import 'package:flutter/material.dart';
import 'package:project/themes/color.dart';
import 'package:project/themes/text.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.white,
  textTheme: textTheme(),
  colorScheme: colorScheme(),
);
