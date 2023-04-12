import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/palette.dart';

class GamaTextField extends StatelessWidget {
  final String? placeholder;
  final TextInputType? keyboardType;
  final bool isObscure;
  final Widget? suffix;
  final String label;

  const GamaTextField({
    super.key,
    this.placeholder,
    this.keyboardType,
    this.isObscure = false,
    this.suffix,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Palette.grey,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        TextFormField(
          keyboardType: keyboardType,
          obscureText: isObscure,
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: suffix,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 2,
                color: Palette.lightGrey,
              ),
            ),
            filled: true,
            fillColor: Palette.lightGrey,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
