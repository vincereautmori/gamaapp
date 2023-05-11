//TODO Adicionar expiresAt e rules
abstract class AuthInfo {
  bool get success;
  int get internalCode;
  double get expiresIn;
  String get role;
  String get token;
}
