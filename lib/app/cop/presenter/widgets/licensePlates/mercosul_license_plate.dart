import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MercosulLicensePlate extends StatelessWidget {
  const MercosulLicensePlate({super.key, required this.licensePlate});
  final String licensePlate;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 260,
        decoration: BoxDecoration(
          color: const Color(0xFFFEFEFE),
          border: Border.all(color: const Color(0xFF535353), width: 4),
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF1d3e93),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: Text(
                "BRASIL",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0xFFFEFEFE),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  height: 0,
                ),
              ),
            ),
            Text(
              licensePlate,
              textAlign: TextAlign.center,
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
