import 'package:flutter/material.dart';
import 'package:gamaapp/shared/utils/sizes.dart';

import '../themes/palette.dart';

class SquaresLines extends StatelessWidget {
  const SquaresLines({super.key});

  @override
  Widget build(BuildContext context) {
    const squaresCount = 18;
    double squareSize = context.fullWidth / squaresCount;
    return Column(
      children: [
        SizedBox(
          height: squareSize,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: squaresCount,
            itemBuilder: (context, index) => Container(
              width: squareSize,
              color: index % 2 == 0 ? Palette.primary : Palette.white,
            ),
          ),
        ),
        SizedBox(
          height: squareSize,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: squaresCount,
            itemBuilder: (context, index) => Container(
              width: squareSize,
              color: index % 2 == 0 ? Palette.white : Palette.primary,
            ),
          ),
        ),
      ],
    );
  }
}
