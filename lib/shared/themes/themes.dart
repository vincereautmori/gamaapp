import 'package:flutter/material.dart';

import 'palette.dart';
import 'text_theme.dart';

class GamaThemes {
  //TODO update to Gama themes

  ThemeData lightTheme = ThemeData(
    colorScheme: Palette.gamaColorScheme,
    textTheme: TextTheme(
      titleLarge: Texts.title,
      titleSmall: Texts.subtitle,
      bodyMedium: Texts.body,
    ),
    splashColor: Palette.primary,
  );
}
