import 'package:gamaapp/app/cop/presenter/controllers/cop_home_controller.dart';
import 'package:get/get.dart';

class CopHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CopHomeController(), permanent: true);
  }
}
