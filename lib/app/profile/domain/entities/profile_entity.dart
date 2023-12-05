import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String email;
  final String username;
  final String fullname;
  final String role;

  const ProfileEntity({
    required this.email,
    required this.username,
    required this.fullname,
    required this.role,
  });

  @override
  List<Object> get props => [
        email,
        username,
        fullname,
        role,
      ];
}
