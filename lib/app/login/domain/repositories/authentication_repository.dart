import 'package:multiple_result/multiple_result.dart';

import '../entities/auth/auth_info.dart';
import '../errors/errors.dart';

abstract class AuthenticationRepository {
  Future<Result<AuthInfo, Failure>> signIn({
    required String email,
    required String password,
  });

  Future<Result<Unit, Failure>> signOut();
}
