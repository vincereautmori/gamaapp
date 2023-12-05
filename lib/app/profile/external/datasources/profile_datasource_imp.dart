import 'package:dio/dio.dart';
import 'package:gamaapp/app/profile/external/hive/profile_hive.dart';
import 'package:gamaapp/app/profile/infra/models/profile_model.dart';
import 'package:hive/hive.dart';

import '../../infra/datasources/profile_datasource.dart';

class ProfileDatasourceImp implements ProfileDatasource {
  final Box<ProfileHive> box;
  final Dio dio;

  ProfileDatasourceImp({
    required this.box,
    required this.dio,
  });

  @override
  Future<ProfileModel?> getProfile() async {
    ProfileHive? hiveModel = box.get('profile');
    return hiveModel?.toModel();
  }

  @override
  Future<void> setProfile({
    required String username,
    required String email,
    required String fullname,
    required String role,
  }) =>
      box.put(
        "profile",
        ProfileHive(
          email: email,
          username: username,
          fullname: fullname,
          role: role,
        ),
      );

  @override
  Future<void> updatePassword(
    String login, {
    required String oldPassword,
    required String newPassword,
  }) =>
      dio.put('/users/$login/password', data: {
        "login": login,
        "newPassword": newPassword,
        "oldPassword": oldPassword
      });
}
