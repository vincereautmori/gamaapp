import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  SplashscreenController();

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 10));
    Get.offAndToNamed('/login');
  }
}
