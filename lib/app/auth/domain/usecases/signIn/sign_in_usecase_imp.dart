import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth_info.dart';
import '../../entities/auth/credentials.dart';
import '../../errors/errors.dart';
import '../../repositories/authentication_repository.dart';
import 'sign_in_usecase.dart';

class SignInUseCaseImp implements SignInUseCase {
  final AuthenticationRepository repository;
  SignInUseCaseImp({required this.repository});

  @override
  Future<Result<AuthInfo, Failure>> signIn(
    CredentialsEntity credentials,
  ) async {
    if (!credentials.isCredentialsValid) {
      return Error(
        CredentialsError(message: "Usuário e senha são obrigatórios"),
      );
    }

    final result = await repository.signIn(
      email: credentials.email,
      password: credentials.password,
    );

    return result;
  }
}
