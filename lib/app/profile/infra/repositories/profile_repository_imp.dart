import 'package:gamaapp/app/profile/infra/models/profile_model.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../../domain/entities/profile_info.dart';
import '../../domain/errors/errors.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_datasource.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileDatasource datasource;

  ProfileRepositoryImp(this.datasource);

  @override
  Future<Result<ProfileInfo, Failure>> getProfileData() async {
    try {
      ProfileModel? model = await datasource.getProfile();

      if (model == null) {
        return Error(
          ProfileError(
            message: "Nenhum dado encontrado",
          ),
        );
      }

      return Success(model);
    } catch (e) {
      return Error(
        ProfileError(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Result<Unit, Failure>> setProfileData({
    required String username,
    required String email,
    required String fullname,
    required String role,
  }) async {
    try {
      await datasource.setProfile(
        username: username,
        email: email,
        fullname: fullname,
        role: role,
      );
      return Success.unit();
    } catch (e) {
      return Error(
        ProfileError(
          message: e.toString(),
        ),
      );
    }
  }
}
