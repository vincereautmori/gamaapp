import '../../domain/entities/signup.dart';
import '../../domain/entities/signup_info.dart';

class SignupModel extends SignupEntity implements SignupInfo {
  const SignupModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.username,
    required super.email,
    required super.documentNumber,
    required super.active,
    required super.roles,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        username: json["username"],
        email: json["email"],
        documentNumber: json["documentNumber"],
        active: json["active"],
        roles: json["roles"].whereType<String>().toList(),
      );
}
// List.castFrom(originalList.whereType<int>())