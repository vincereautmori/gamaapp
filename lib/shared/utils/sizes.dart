import 'package:flutter/material.dart';

extension SizesExtension on BuildContext {
  double get fullHeight => MediaQuery.of(this).size.height;
  double get fullWidth => MediaQuery.of(this).size.width;

  double percentHeight(double percent) => fullHeight * percent;
  double percentWidth(double percent) => fullWidth * percent;
}
