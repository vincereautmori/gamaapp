import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final bool success;
  final int internalCode;
  final String token;
  final double expiresIn;
  final String role;

  @override
  List get props => [success, internalCode, token, expiresIn, role];

  const AuthEntity({
    this.success = false,
    required this.internalCode,
    required this.token,
    required this.expiresIn,
    required this.role,
  });
}
