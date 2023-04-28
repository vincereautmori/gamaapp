import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth.dart';
import '../../errors/errors.dart';

abstract class LoadSecureToken {
  Future<Result<AuthEntity, Failure>> load(AuthEntity account);
}
