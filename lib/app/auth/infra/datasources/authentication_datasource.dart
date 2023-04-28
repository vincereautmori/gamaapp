import '../models/auth_model.dart';

abstract class AuthenticationDatasource {
  Future<AuthModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
