import 'package:multiple_result/multiple_result.dart';

import '../../errors/errors.dart';

abstract class SignOutUseCase {
  Future<Result<Unit, Failure>> signOut();
}
