import 'package:equatable/equatable.dart';

import '../../extensions/string_extension.dart';

class CredentialsEntity extends Equatable {
  final String companyDocument;
  final String email;
  final String password;

  const CredentialsEntity({
    required this.companyDocument,
    required this.email,
    required this.password,
  });

  bool get isEmailValid => email.isEmailValid();

  bool get isPasswordValid => password.isNotEmpty;

  bool get isCredentialsValid => isEmailValid && isPasswordValid;

  @override
  List<Object?> get props => [email, password];
}
