import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

class Texts {
  //TODO change text styles to GAMA style, following figma

  static TextStyle title = GoogleFonts.montserrat(
    color: Palette.black,
    fontWeight: FontWeight.w500,
    fontSize: 26,
  );

  static TextStyle cardTitle = GoogleFonts.montserrat(
    color: Palette.primary,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  static TextStyle subtitle = GoogleFonts.montserrat(
    color: Palette.darkGrey,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static TextStyle body = GoogleFonts.montserrat(
    color: Palette.black,
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
