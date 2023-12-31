import '../models/profile_model.dart';

abstract class ProfileDatasource {
  Future<void> setProfile({
    required String username,
    required String email,
    required String fullname,
    required String role,
  });

  Future<ProfileModel?> getProfile();

  Future<void> updatePassword(
    String login, {
    required String oldPassword,
    required String newPassword,
  });
}
