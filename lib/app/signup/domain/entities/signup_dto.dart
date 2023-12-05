import 'package:equatable/equatable.dart';
import 'package:gamaapp/shared/extensions/string_extension.dart';

class SignupDto extends Equatable {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String documentNumber;

  const SignupDto({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.email,
    required this.documentNumber,
  });

  bool get isEmailValid => email.isEmailValid;
  bool get isDocumentValid => documentNumber.isDocumentValid;
  bool get isFirstNameValid => firstName.isNotEmpty;
  bool get isLastNameValid => lastName.isNotEmpty;
  bool get isUsernameValid => username.isNotEmpty;
  bool get isPasswordValid => password.isNotEmpty;

  bool get isInputValid =>
      isEmailValid &&
      isDocumentValid &&
      isFirstNameValid &&
      isLastNameValid &&
      isUsernameValid &&
      isPasswordValid;

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        username,
        email,
        password,
        documentNumber,
      ];
}
