import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/signup/domain/entities/signup_dto.dart';
import 'package:gamaapp/app/signup/domain/entities/signup_info.dart';
import 'package:gamaapp/app/signup/domain/errors/errors.dart';
import 'package:multiple_result/multiple_result.dart';

import '../repositories/signup_repository.dart';
import 'create_account_usecase.dart';

class CreateAccountUsecaseImp implements CreateAccountUsecase {
  final SignupRepository repository;

  CreateAccountUsecaseImp(this.repository);

  @override
  Future<Result<SignupInfo, Failure>> call(SignupDto dto) async {
    if (!dto.isInputValid) {
      return Error(SignUpError(message: "Por favor, revise o formulário"));
    }

    return repository.signUp(
      firstName: dto.firstName,
      password: dto.password,
      lastName: dto.lastName,
      username: dto.username,
      email: dto.email,
      documentNumber: dto.documentNumber,
    );
  }
}
