import 'package:flutter/material.dart';

class Palette {
  //TODO change collors to GAMA style, following figma palette
  static const Color primary = Color(0xFF1A5DC9);
  static const Color secondary = Color(0xFFD6E5FF);
  static const Color tertiary = Color(0xFF012C67);
  static const Color black = Color(0xFF2B2B2B);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orange = Color(0xFFFC9D03);
  static const Color grey = Color(0xFF858585);
  static const Color lightGrey = Color(0xFFDDDDDD);
  static const Color green = Color(0xFF7FC8A9);
  static const Color lightGreen = Color(0xFFBCDCCF);
  static const Color darkGreen = Color(0xFF39A388);
  static const Color red = Color(0xFFFA8072);
  static const Color darkRed = Color(0xFFF55C47);
  static const Color blue = Color(0xFF5C7AEA);
  static const Color darkBlue = Color(0xFF0F52BA);
  static const Color yellow = Color(0xFFFFD700);
  static const Color purple = Color(0xFFA790F5);

  static const ColorScheme gamaColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: white,
    secondary: secondary,
    onSecondary: black,
    background: white,
    onBackground: black,
    error: red,
    onError: white,
    surface: white,
    onSurface: grey,
    tertiary: tertiary,
  );
}
