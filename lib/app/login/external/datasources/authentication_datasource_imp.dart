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
    Response response = await dio.post('/login', data: {
      "email": email,
      "password": password,
    });
    return AuthModel(
      internalCode: 1, //response.data['internalCode'],
      token: response.data['accessToken'], //response.data['token'],
      success: response.data != null, //response.data['success'],
    );
  }

  @override
  Future<void> signOut() async {}
}
