import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class UpdatePasswordUsecase {
  Future<Result<Unit, Failure>> call(
    String login, {
    required String oldPassword,
    required String newPassword,
  });
}
