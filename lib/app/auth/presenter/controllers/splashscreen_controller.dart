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

    result.whenSuccess((success) => null);
    await Future.delayed(const Duration(seconds: 3));
    Get.offAndToNamed('/login');
  }
}
