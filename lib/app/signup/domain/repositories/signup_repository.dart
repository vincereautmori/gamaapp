import 'package:gamaapp/app/signup/domain/entities/signup_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';

abstract class SignupRepository {
  Future<Result<SignupInfo, Failure>> signUp({
    required firstName,
    required lastName,
    required username,
    required password,
    required email,
    required documentNumber,
  });
}
