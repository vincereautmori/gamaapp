import 'package:gamaapp/shared/themes/snackbar_styles.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/entities/auth/auth.dart';
import '../../domain/errors/errors.dart';
import '../../domain/usecases/loadSecureToken/load_secure_token_usecase.dart';

class SplashscreenController extends GetxController {
  final LoadSecureToken _usecase;

  SplashscreenController(this._usecase);

  @override
  void onInit() async {
    super.onInit();
    Result<AuthEntity, Failure> result = await _usecase.load();

    await Future.delayed(const Duration(seconds: 3));
    result.when((success) => Get.offAndToNamed('/success'), (error) {
      utils.callSnackBar(
        title: "Falha na autenticação",
        message: error.message,
        snackStyle: SnackBarStyles.warning,
      );
      Get.offAndToNamed('/login');
    });
  }
}
