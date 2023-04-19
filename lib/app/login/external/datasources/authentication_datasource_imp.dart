import 'package:dio/dio.dart';

import '../../infra/datasources/authentication_datasource.dart';
import '../../infra/models/auth_model.dart';

class AuthenticationDatasourceImp implements AuthenticationDatasource {
  final Dio dio;

  AuthenticationDatasourceImp(this.dio);

  @override
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    Response response = await dio.post('/token', data: {
      "login": email,
      "password": password,
    });
    return AuthModel(
      internalCode: 1,
      token: response.data['token'],
      success: response.data != null,
    );
  }

  @override
  Future<void> signOut() async {}
}
