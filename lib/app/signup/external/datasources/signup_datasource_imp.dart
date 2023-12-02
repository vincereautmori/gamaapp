import 'package:dio/dio.dart';
import 'package:gamaapp/app/signup/infra/models/signup_model.dart';

import '../../infra/datasources/signup_datasource.dart';

class SignupDatasourceImp implements SignupDatasource {
  final Dio dio;

  SignupDatasourceImp(this.dio);

  @override
  Future<SignupModel> signUp({
    required firstName,
    required lastName,
    required username,
    required password,
    required email,
    required documentNumber,
  }) async {
    Response response = await dio.post('/users', data: {
      "firstName": firstName,
      "lastName": lastName,
      "username": username,
      "password": password,
      "email": email,
      "documentNumber": documentNumber,
    });

    SignupModel createdUserData = SignupModel.fromJson(response.data);

    return createdUserData;
  }
}
