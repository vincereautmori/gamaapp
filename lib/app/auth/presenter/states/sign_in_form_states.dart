import 'package:get/get.dart';

class SignInFormStates {
  static final email = "".obs;
  static final Rx<String?> emailError = null.obs;

  static final password = "".obs;

  static final isLoading = false.obs;

  static clear() {
    isLoading.value = false;
    email.value = "";
    password.value = "";
    emailError.value = null;
  }
}
