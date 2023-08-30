import 'package:get/get.dart';

class HistoricController extends GetxController {
  HistoricController();

  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}
