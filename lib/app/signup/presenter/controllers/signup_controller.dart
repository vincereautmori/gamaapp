import 'package:flutter/material.dart';
import 'package:gamaapp/app/auth/presenter/controllers/sign_in_controller.dart';
import 'package:gamaapp/app/signup/domain/usecases/create_account_usecase.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/themes/snackbar_styles.dart';
import '../../../../shared/utils/loading.dart';
import '../../../../shared/utils/utils.dart';
import '../../../auth/domain/errors/errors.dart';
import '../../domain/entities/signup_dto.dart';
import '../../domain/entities/signup_info.dart';
import '../states/signup_states.dart';

class SignupController extends GetxController with Loading {
  final CreateAccountUsecase createAccount;

  SignupController(this.createAccount);

  AuthenticationController authController = Get.find();

  Key get signUpKey => GlobalKey<FormState>(
        debugLabel: "signUp",
      );

  bool get isLoading => [
        LoadingStates.creteUser,
        LoadingStates.login,
      ].contains(loadingState.value);

  String get firstName => SignupStates.firstNameInput.value.text;

  String get lastName => SignupStates.lastNameInput.value.text;

  String get username => SignupStates.usernameInput.value.text;

  String get email => SignupStates.emailInput.value.text;

  String get password => SignupStates.passwordInput.value.text;

  String get documentNumber => SignupStates.documentNumberInput.value.text;

  Future<void> signUp() async {
    setLoading(LoadingStates.creteUser);

    Result<SignupInfo, Failure> result = await createAccount(
      SignupDto(
        firstName: firstName,
        lastName: lastName,
        username: username,
        password: password,
        email: email,
        documentNumber: documentNumber,
      ),
    );

    result.when(
      (info) async {
        utils.callSnackBar(
          title: "Usuário criado com sucesso!",
          message: "Redirecionando para a tela inicial...",
          snackStyle: SnackBarStyles.success,
        );
        authController.setEmail(info.email);
        authController.setPassword(password);

        await authController.signIn();
        SignupStates.clear();
      },
      (error) => utils.callSnackBar(
        title: "Algo deu errado",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      ),
    );
    stopLoading();
  }
}
