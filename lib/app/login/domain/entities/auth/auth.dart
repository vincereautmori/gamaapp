class AuthEntity {
  final bool success;
  final int internalCode;
  final String token;

  AuthEntity({
    this.success = false,
    required this.internalCode,
    required this.token,
  });
}
