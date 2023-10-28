import 'package:flutter/material.dart';

import 'palette.dart';
import 'text_theme.dart';

class GamaThemes {
  ThemeData lightTheme = ThemeData(
    colorScheme: Palette.gamaColorScheme,
    useMaterial3: true,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Palette.primary,
      foregroundColor: Palette.white,
    ),
    chipTheme: ChipThemeData(
        checkmarkColor: Colors.white,
        color: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.selected)) {
              return Palette.primary;
            }
            return Colors.transparent;
          },
        )),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: Texts.title,
      titleSmall: Texts.subtitle,
      bodyMedium: Texts.body,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          width: 2,
          color: Palette.lightGrey,
        ),
      ),
      filled: true,
      fillColor: Palette.lightGrey,
      hintStyle: const TextStyle(
        color: Palette.grey,
        fontWeight: FontWeight.normal,
      ),
    ),
    splashColor: Palette.primary,
  );
}
