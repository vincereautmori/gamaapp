import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupStates {
  static final Rx<TextEditingController> firstNameInput = Rx(
    TextEditingController(),
  );

  static final Rx<TextEditingController> lastNameInput = Rx(
    TextEditingController(),
  );

  static final Rx<TextEditingController> usernameInput = Rx(
    TextEditingController(),
  );

  static final Rx<TextEditingController> emailInput = Rx(
    TextEditingController(),
  );

  static final Rx<TextEditingController> passwordInput = Rx(
    TextEditingController(),
  );

  static final Rx<TextEditingController> documentNumberInput = Rx(
    TextEditingController(),
  );

  static void clear() {
    firstNameInput.value.clear();
    lastNameInput.value.clear();
    usernameInput.value.clear();
    emailInput.value.clear();
    passwordInput.value.clear();
    documentNumberInput.value.clear();
  }
}
