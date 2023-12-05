import 'package:get/get.dart';

import '/app/cop/presenter/controllers/cop_home_controller.dart';

class CopHomeBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => CopHomeController(), fenix: true);
}
