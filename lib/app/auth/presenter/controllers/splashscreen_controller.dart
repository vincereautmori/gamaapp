import 'package:get/get.dart';

import '../../domain/usecases/loadSecureToken/load_secure_token_usecase.dart';

class SplashscreenController extends GetxController {
  final LoadSecureToken _usecase;

  SplashscreenController(this._usecase);

  @override
  void onInit() async {
    super.onInit();
    var teste = await _usecase.load();
    await Future.delayed(const Duration(seconds: 3));
    Get.offAndToNamed('/login');
  }
}
