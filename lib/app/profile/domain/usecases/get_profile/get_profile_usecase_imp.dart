import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/profile_info.dart';
import '../../repositories/profile_repository.dart';
import 'get_profile_usecase.dart';

class GetProfileUsecaseImp implements GetProfileUsecase {
  final ProfileRepository repository;

  GetProfileUsecaseImp(this.repository);

  @override
  Future<Result<ProfileInfo, Failure>> call() => repository.getProfileData();
}
