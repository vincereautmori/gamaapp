import 'package:flutter/material.dart';
import 'package:gamaapp/shared/themes/palette.dart';
import 'package:gamaapp/shared/widgets/square_line.dart';

import '../../../../../shared/themes/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        verticalDirection: VerticalDirection.down,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                Images.logoPNG,
                height: 168,
                width: 168,
              ),
            ),
          ),
          const LinearProgressIndicator(),
          const SquaresLines()
        ],
      ),
    );
  }
}
