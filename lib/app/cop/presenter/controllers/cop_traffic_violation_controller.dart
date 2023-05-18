import 'package:get/get.dart';

import '../../../auth/domain/usecases/loadSecureToken/load_secure_token_usecase.dart';

class CopTrafficViolationController extends GetxController {
  final LoadSecureToken secureStorage;

  CopTrafficViolationController(this.secureStorage);
}
