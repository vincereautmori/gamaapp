import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/entities/auth/auth.dart';
import '../../domain/entities/auth/auth_info.dart';
import '../../domain/entities/auth/credentials.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/saveSecureToken/save_secure_token_usecase.dart';
import '../../domain/usecases/signIn/sign_in_usecase.dart';
import '../states/sign_in_form_states.dart';

class SignInController extends GetxController {
  final SignInUseCase _usecase;
  final SaveSecureToken _saveSecureToken;

  SignInController(this._usecase, this._saveSecureToken);

  String get email => SignInFormStates.email.value;
  String get password => SignInFormStates.password.value;
  bool get isLoading => SignInFormStates.isLoading.value;

  void setEmail(String newEmailValue) =>
      SignInFormStates.email.value = newEmailValue;
  void setPassword(String newPasswordValue) =>
      SignInFormStates.password.value = newPasswordValue;

  CredentialsEntity get credentials => CredentialsEntity(
        email: email,
        password: password,
      );

  bool get isEmailValid => credentials.isEmailValid;
  bool get isPasswordValid => credentials.isPasswordValid;

  bool get isFormValid => credentials.isCredentialsValid;

  Future<void> signIn() async {
    SignInFormStates.isLoading.toggle();
    Result<AuthInfo, Failure> result = await _usecase.signIn(credentials);
    SignInFormStates.isLoading.toggle();
    result.when(
      (authInfo) async {
        await _saveSecureToken.save(authInfo as AuthEntity);
        Get.offAllNamed('/success');
      },
      (error) => utils.callSnackBar(
        title: "Falha na autenticação",
        message: error.message,
        snackStyle: error.runtimeType == AuthenticationError
            ? SnackBarStyles.warning
            : SnackBarStyles.error,
      ),
    );
  }
}
