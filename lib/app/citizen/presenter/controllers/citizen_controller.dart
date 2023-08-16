import 'package:get/get.dart';

class CitizenController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
