import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OldLicensePlate extends StatelessWidget {
  const OldLicensePlate({super.key, required this.licensePlate});
  final String licensePlate;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFd9d9db),
          border: Border.all(color: const Color(0xFF818181), width: 4),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              "Placa",
              style: GoogleFonts.inter(
                color: const Color(0xFF2a2a2c),
                fontWeight: FontWeight.w700,
                fontSize: 12,
                height: 0,
              ),
            ),
            Text(
              licensePlate,
              style: GoogleFonts.inter(
                color: const Color(0xFF2a2a2c),
                fontWeight: FontWeight.w700,
                fontSize: 32,
                height: 0,
              ),
            ),
          ],
        ));
  }
}
