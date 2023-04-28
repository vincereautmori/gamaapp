import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/entities/auth/auth_info.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_datasource.dart';
import '../models/auth_model.dart';

class AuthenticationRepositoryImp implements AuthenticationRepository {
  final AuthenticationDatasource datasource;

  AuthenticationRepositoryImp(this.datasource);

  @override
  Future<Result<AuthInfo, Failure>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      AuthModel auth = await datasource.signIn(
        email: email,
        password: password,
      );
      return Success(auth);
    } on DioError catch (e) {
      //DioErrorType.response
      if (e.type == DioErrorType.badResponse) {
        return Error(
          AuthenticationError(
            message: "Usuário ou senha incorretos!",
          ),
        );
      }
      if (e.type == DioErrorType.cancel) {
        return Error(
          AuthenticationError(
            message: "Conexão com o servidor cancelada",
          ),
        );
      }
      if (e.type == DioErrorType.connectionTimeout) {
        return Error(
          AuthenticationServerError(
            message:
                "Não foi possível se conectar com o servidor dentro do limite de tempo",
          ),
        );
      }
      if (e.type == DioErrorType.receiveTimeout) {
        return Error(
          AuthenticationServerError(
            message: "Tempo de resposta excedido",
          ),
        );
      }
      if (e.type == DioErrorType.sendTimeout) {
        return Error(
          AuthenticationServerError(
            message: "Tempo de envio excedido",
          ),
        );
      }
      return Error(
        AuthenticationServerError(
          message: "Não foi possível se conectar com o servidor!",
        ),
      );
    } catch (e) {
      return Error(
        AuthenticationServerError(
          message: "Houve um erro inesperado - Tente novamente mais tarde!",
        ),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> signOut() async {
    try {
      await datasource.signOut();
      return const Success(unit);
    } catch (e) {
      return Error(SignOutError(message: "Algo deu errado: $e"));
    }
  }
}
