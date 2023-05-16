abstract class Failure implements Exception {
  String get message;
}

class CredentialsError extends Failure {
  @override
  final String message;
  CredentialsError({required this.message});
}

class AuthenticationServerError extends Failure {
  @override
  final String message;
  AuthenticationServerError({required this.message});
}

class AuthenticationError extends Failure {
  @override
  final String message;
  AuthenticationError({required this.message});
}

class SignOutError extends Failure {
  @override
  final String message;
  SignOutError({required this.message});
}

class CacheError extends Failure {
  @override
  final String message;
  CacheError({required this.message});
}

class ExpiredTokenError extends Failure {
  @override
  final String message;
  ExpiredTokenError({required this.message});
}
