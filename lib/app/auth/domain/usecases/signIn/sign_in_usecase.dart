import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth_info.dart';
import '../../entities/auth/credentials.dart';
import '../../errors/errors.dart';

abstract class SignInUseCase {
  Future<Result<AuthInfo, Failure>> signIn(CredentialsEntity credentials);
}
