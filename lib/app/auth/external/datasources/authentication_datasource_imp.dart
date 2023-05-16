import 'package:dio/dio.dart';
import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/routes.dart';
import 'package:get/route_manager.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../infra/datasources/authentication_datasource.dart';
import '../../infra/models/auth_model.dart';

class AuthenticationDatasourceImp implements AuthenticationDatasource {
  final Dio dio;

  AuthenticationDatasourceImp(this.dio);

  String? decodeTokenAndGetRole(String? token) {
    if (token == null || token.isEmpty) {
      throw AuthenticationError(message: 'Token não informado');
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return decodedToken['role'];
  }

  @override
  Future<AuthModel> signIn({
    required String email,
    required String password,
  }) async {
    Response response = await dio.post('/v1/auth/token', data: {
      "login": email,
      "password": password,
    });

    String? token = response.data['token'];

    String? role = decodeTokenAndGetRole(token);

    return AuthModel(
      internalCode: 1,
      token: token ?? "",
      expiresIn: response.data['expiresIn'],
      role: role ?? "",
      success: response.data != null,
    );
  }

  @override
  Future<void> signOut() async {
    Get.offAllNamed(Routes.login.name);
  }
}
