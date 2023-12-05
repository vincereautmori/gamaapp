import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../entities/profile_info.dart';

abstract class ProfileRepository {
  Future<Result<Unit, Failure>> setProfileData({
    required String username,
    required String email,
    required String fullname,
    required String role,
  });

  Future<Result<ProfileInfo, Failure>> getProfileData();

  Future<Result<Unit, Failure>> updatePassword(
    String login, {
    required String oldPassword,
    required String newPassword,
  });
}
