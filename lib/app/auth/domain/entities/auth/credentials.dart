import 'package:equatable/equatable.dart';

class CredentialsEntity extends Equatable {
  final String email;
  final String password;

  const CredentialsEntity({
    required this.email,
    required this.password,
  });

  bool get isEmailValid => email.isNotEmpty;

  bool get isPasswordValid => password.isNotEmpty;

  bool get isCredentialsValid => isEmailValid && isPasswordValid;

  @override
  List<Object?> get props => [email, password];
}
