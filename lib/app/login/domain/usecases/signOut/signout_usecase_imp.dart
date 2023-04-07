import 'package:multiple_result/multiple_result.dart';

import '../../errors/errors.dart';
import '../../repositories/authentication_repository.dart';
import 'signout_usecase.dart';

class SignOutUseCaseImp implements SignOutUseCase {
  final AuthenticationRepository repository;

  SignOutUseCaseImp(this.repository);

  @override
  Future<Result<Unit, Failure>> signOut() async {
    return await repository.signOut();
  }
}
