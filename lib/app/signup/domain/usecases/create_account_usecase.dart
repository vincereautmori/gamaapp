import 'package:gamaapp/app/signup/domain/entities/signup_dto.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../entities/signup_info.dart';

abstract class CreateAccountUsecase {
  Future<Result<SignupInfo, Failure>> call(SignupDto dto);
}
