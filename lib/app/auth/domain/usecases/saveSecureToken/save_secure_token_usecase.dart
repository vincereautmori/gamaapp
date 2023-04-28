import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth.dart';
import '../../errors/errors.dart';

abstract class SaveSecureToken {
  Future<Result<Unit, Failure>> save(AuthEntity account);
}
