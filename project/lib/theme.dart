import 'package:flutter/material.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class KeyColor {
  static Color primary = const Color(0xFF65558F);
  static Color secondary = const Color(0xFF625B71);
  static Color tertiary = const Color(0xFF7D5260);
  static Color neutral = const Color(0xFF605E5E);
  static Color neutralVariant = const Color(0xFF605E5F);
  static Color error = const Color(0xFFB3261E);
}

extension Material3Palette on Color {
  Color tone(int tone) {
    assert(tone >= 0 && tone <= 100);
    final color = Hct.fromInt(value);
    final tonalPalette = TonalPalette.of(color.hue, color.chroma);
    return Color(tonalPalette.get(tone));
  }
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.white,
  textTheme: textTheme(),
  colorScheme: colorScheme(),
);

ColorScheme colorScheme() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: KeyColor.primary,
    onPrimary: KeyColor.primary.tone(100),
    primaryContainer: KeyColor.primary.tone(90),
    onPrimaryContainer: KeyColor.primary.tone(30),
    secondary: KeyColor.secondary,
    onSecondary: KeyColor.secondary.tone(100),
    secondaryContainer: KeyColor.secondary.tone(90),
    onSecondaryContainer: KeyColor.secondary.tone(30),
    tertiary: KeyColor.tertiary,
    onTertiary: KeyColor.tertiary.tone(100),
    tertiaryContainer: KeyColor.tertiary.tone(90),
    onTertiaryContainer: KeyColor.tertiary.tone(10),
    error: KeyColor.error.tone(40),
    onError: KeyColor.error.tone(100),
    errorContainer: KeyColor.error.tone(90),
    onErrorContainer: KeyColor.error.tone(30),
    surfaceDim: KeyColor.neutral.tone(87),
    surface: KeyColor.neutral.tone(99),
    surfaceBright: KeyColor.neutral.tone(98),
    surfaceContainerLowest: KeyColor.neutral.tone(100),
    surfaceContainerLow: KeyColor.neutral.tone(96),
    surfaceContainer: KeyColor.neutral.tone(94),
    surfaceContainerHigh: KeyColor.neutral.tone(92),
    surfaceContainerHighest: KeyColor.neutral.tone(90),
    onSurface: KeyColor.neutral.tone(10),
    onSurfaceVariant: KeyColor.neutralVariant.tone(30),
    outline: KeyColor.neutralVariant.tone(50),
    outlineVariant: KeyColor.neutralVariant.tone(80),
    inverseSurface: KeyColor.neutral.tone(90),
    inversePrimary: KeyColor.primary.tone(90),
    scrim: KeyColor.neutral.tone(0),
    shadow: KeyColor.neutral.tone(0),
  );
}

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
