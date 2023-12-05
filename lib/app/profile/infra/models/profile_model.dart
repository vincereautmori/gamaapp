import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/profile_info.dart';

class ProfileModel extends ProfileEntity implements ProfileInfo {
  const ProfileModel({
    required super.email,
    required super.username,
    required super.fullname,
    required super.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        username: json["sub"],
        email: json["email"],
        role: json["role"],
        fullname: json["name"],
      );
}
