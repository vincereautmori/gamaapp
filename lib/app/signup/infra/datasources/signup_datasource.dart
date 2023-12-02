import '../models/signup_model.dart';

abstract class SignupDatasource {
  Future<SignupModel> signUp({
    required firstName,
    required lastName,
    required username,
    required password,
    required email,
    required documentNumber,
  });
}
