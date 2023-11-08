import 'package:gamaapp/app/cop/presenter/controllers/cop_home_controller.dart';
import 'package:get/get.dart';

import '../../../ocurrences/presenter/controllers/ocurrences_controller.dart';

class CopHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CopHomeController(), fenix: true);
    Get.lazyPut(() => OcurrencesController(), fenix: true);
  }
}
