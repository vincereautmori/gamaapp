import 'package:multiple_result/multiple_result.dart';

import '../../../login/domain/entities/auth/auth.dart';
import '../../../login/domain/errors/errors.dart';

abstract class LoadSecureToken {
  Future<Result<AuthEntity, Failure>> load(AuthEntity account);
}
