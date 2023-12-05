import 'package:hive/hive.dart';

import '../../infra/models/profile_model.dart';

part 'profile_hive.g.dart';

@HiveType(typeId: 0)
class ProfileHive extends HiveObject {
  @HiveField(0)
  final String email;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String fullname;

  @HiveField(3)
  final String role;

  ProfileModel toModel() => ProfileModel(
        email: email,
        username: username,
        fullname: fullname,
        role: role,
      );

  ProfileHive({
    required this.email,
    required this.username,
    required this.fullname,
    required this.role,
  });
}
