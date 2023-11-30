import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';
import '../../entities/properties/properties_info.dart';

abstract class GetPropertiesUsecase {
  Future<Result<OccurrencePropertiesInfo, Failure>> call();
}
