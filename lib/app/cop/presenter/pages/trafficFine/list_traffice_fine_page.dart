import 'package:flutter/material.dart';

import '../../../../../shared/themes/images.dart';
import '../../../../../shared/themes/palette.dart';
import '../../../../../shared/widgets/square_line.dart';

class TrafficFineList extends StatelessWidget {
  const TrafficFineList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Palette.primary,
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Center(
                child: Image.asset(
                  Images.logoPNG,
                  height: 138,
                  width: 138,
                ),
              ),
            ),
            const SquaresLines(),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
