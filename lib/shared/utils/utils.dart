import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/palette.dart';
import '../themes/snackbar_styles.dart';

Utils utils = Utils.instance;

class Utils {
  static Utils? _instance;

  Utils._();
  static Utils get instance {
    _instance ??= Utils._();
    return _instance!;
  }

  void callSnackBar({
    required String title,
    required String message,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    SnackBarStyles snackStyle = SnackBarStyles.normal,
    Widget? icon,
    Color colorText = Palette.white,
    bool isFloating = false,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: snackStyle.value,
      icon: icon,
      colorText: colorText,
      snackStyle: isFloating ? SnackStyle.FLOATING : SnackStyle.GROUNDED,
    );
  }
}
