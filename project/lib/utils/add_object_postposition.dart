import 'package:flutter/material.dart';

String addObjectPostposition(String input) {
  if (input.isEmpty) return "";

  final lastChar = input.characters.last;
  final codeUnit = lastChar.codeUnitAt(0);

  if (codeUnit >= 0xAC00 && codeUnit <= 0xD7A3) {
    final jongseongIndex = (codeUnit - 0xAC00) % 28;
    return jongseongIndex == 0 ? '$input를' : '$input을';
  }

  return '$input를';
}
