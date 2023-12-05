import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/profile_info.dart';

abstract class GetProfileUsecase {
  Future<Result<ProfileInfo, Failure>> call();
}
