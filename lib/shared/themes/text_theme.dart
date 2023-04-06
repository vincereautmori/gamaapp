import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

class Texts {
    //TODO change text styles to GAMA style, following figma

  static TextStyle title = GoogleFonts.raleway(
    color: Palette.black,
    fontSize: 32,
  );

  static TextStyle subtitle = GoogleFonts.raleway(
    color: Palette.black,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  static TextStyle body = GoogleFonts.raleway(
    color: Palette.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
