import 'package:flutter/material.dart';

class Palette {
  static const Color primary = Color(0xFF154572);
  static const Color red = Color(0xFFed1b26);
  static const Color black = Color(0xFF202020);
  static const Color white = Color(0xFFffffff);
  static const Color darkGrey = Color(0xFF646262);
  static const Color grey = Color(0xFF949494);
  static const Color lightGrey = Color(0xFFeeeeee);
  static const Color greyBackground = Color(0xFFF4F4F4);
  static const Color warning = Color(0xFFFF9800);

  static const ColorScheme gamaColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    secondary: red,
    onSecondary: black,
    background: white,
    onBackground: black,
    error: black,
    onError: white,
    surface: white,
    onSurface: grey,
    tertiary: warning,
  );
}
