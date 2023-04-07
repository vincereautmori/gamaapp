import 'package:flutter/material.dart';

import 'palette.dart';

enum SnackBarStyles {
  normal(Palette.black),
  success(Colors.green),
  warning(Palette.warning),
  error(Palette.red);

  final Color value;

  const SnackBarStyles(this.value);
}
