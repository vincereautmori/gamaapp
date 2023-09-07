import 'package:flutter/material.dart';
import 'package:gamaapp/shared/themes/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/palette.dart';

class GamaTextField extends StatelessWidget {
  final String? placeholder;
  final TextInputType? keyboardType;
  final bool isObscure;
  final Widget? suffix;
  final int? maxLines;
  final String label;
  final void Function(String)? onChange;

  const GamaTextField({
    super.key,
    this.placeholder,
    this.keyboardType,
    this.isObscure = false,
    this.suffix,
    required this.label,
    this.onChange,
    this.maxLines = 1,
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
          style: Texts.body,
          keyboardType: keyboardType,
          obscureText: isObscure,
          onChanged: onChange,
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: suffix,
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
