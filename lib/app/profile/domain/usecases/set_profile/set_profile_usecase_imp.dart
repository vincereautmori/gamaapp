import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/profile/domain/entities/profile_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../repositories/profile_repository.dart';
import 'set_profile_usecase.dart';

class SetProfileUsecaseImp implements SetProfileUsecase {
  final ProfileRepository repository;

  SetProfileUsecaseImp(this.repository);

  @override
  Future<Result<Unit, Failure>> call(ProfileInfo profile) =>
      repository.setProfileData(
        username: profile.username,
        email: profile.email,
        fullname: profile.fullname,
        role: profile.role,
      );
}
