import 'package:equatable/equatable.dart';

class SignupEntity extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String documentNumber;
  final bool active;
  final List<String> roles;

  const SignupEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.documentNumber,
    required this.active,
    required this.roles,
  });

  @override
  List<Object> get props => [
        id,
        firstName,
        lastName,
        username,
        email,
        documentNumber,
        active,
        roles,
      ];
}
