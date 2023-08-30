import 'package:get/get.dart';

class MapPageController extends GetxController {
  MapPageController();

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
