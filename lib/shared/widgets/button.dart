import 'package:flutter/material.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class GamaButton extends StatelessWidget {
  const GamaButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.isLoading})
      : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
      ),
      child: isLoading
          ? const SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                color: Palette.white,
                strokeWidth: 2,
              ))
          : Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
