import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:get/get.dart';

class CopHomeController extends GetxController {
  void goToOcurrence() => Get.toNamed('/cop/${RoutesNames.ocurrence}');
  void goToTrafficFine() => Get.toNamed('/cop${RoutesNames.trafficFine}');
}
