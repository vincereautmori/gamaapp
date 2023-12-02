import 'package:gamaapp/app/auth/domain/usecases/clearSecureStorage/clear_secure_storage_usecase.dart';
import 'package:gamaapp/app/auth/domain/usecases/signOut/signout_usecase.dart';
import 'package:gamaapp/app/auth/presenter/states/splash_screen_states.dart';
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

class AuthenticationController extends GetxController {
  final SignInUseCase authUseCase;
  final SignOutUseCase logoutUseCase;
  final SaveSecureToken saveSecureToken;
  final ClearSecureStorage clearSecureStorage;

  AuthenticationController({
    required this.authUseCase,
    required this.saveSecureToken,
    required this.clearSecureStorage,
    required this.logoutUseCase,
  });

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
    Result<AuthInfo, Failure> result = await authUseCase.signIn(credentials);
    SignInFormStates.isLoading.toggle();
    result.when(
      (authInfo) async {
        if (authInfo.role == 'Citizen') {
          utils.callSnackBar(
            title: "Login desabilitado",
            message:
                "Acessar o sistema como cidadão está desabilitado nessa versão.",
            snackStyle: SnackBarStyles.warning,
            isFloating: true,
          );
        } else {
          await saveSecureToken.save(authInfo as AuthEntity);
          Get.offAllNamed(
              '/${SplashScreenStates.successRoutes[authInfo.role]}');
        }
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

  Future<void> signOut() async {
    SignInFormStates.clear();
    await clearSecureStorage.clear();
    await logoutUseCase.signOut();
  }
}
