import 'package:dio/dio.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/signup/domain/entities/signup_info.dart';
import 'package:gamaapp/app/signup/domain/errors/errors.dart';
import 'package:gamaapp/app/signup/infra/datasources/signup_datasource.dart';
import 'package:gamaapp/app/signup/infra/models/signup_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/repositories/signup_repository.dart';

class SignupRepositoryImp implements SignupRepository {
  final SignupDatasource datasource;

  SignupRepositoryImp(this.datasource);

  @override
  Future<Result<SignupInfo, Failure>> signUp({
    required firstName,
    required lastName,
    required username,
    required password,
    required email,
    required documentNumber,
  }) async {
    try {
      SignupModel model = await datasource.signUp(
        firstName: firstName,
        lastName: lastName,
        username: username,
        password: password,
        email: email,
        documentNumber: documentNumber,
      );

      return Success(model);
    } on DioException catch (e) {
      String errorMessage = "Algo deu errado";

      if (e.response?.data["command.DocumentNumber"] != null) {
        errorMessage = e.response!.data["command.DocumentNumber"];
      }

      if (e.response?.data["errors"]["User"].first != null) {
        errorMessage = e.response!.data["errors"]["User"].first;
      }

      return Error(SignUpError(message: errorMessage));
    } catch (e) {
      return Error(
        SignUpError(
          message: "Algo inesperado aconteceu, tente novamente mais tarde",
        ),
      );
    }
  }
}
