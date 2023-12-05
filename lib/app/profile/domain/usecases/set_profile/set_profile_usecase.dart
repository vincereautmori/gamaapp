import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/profile_info.dart';

abstract class SetProfileUsecase {
  Future<Result<Unit, Failure>> call(ProfileInfo profile);
}
