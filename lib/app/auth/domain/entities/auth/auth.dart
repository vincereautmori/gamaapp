import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final bool success;
  final int internalCode;
  final String token;

  @override
  List get props => [success, internalCode, token];

  const AuthEntity({
    this.success = false,
    required this.internalCode,
    required this.token,
  });
}
