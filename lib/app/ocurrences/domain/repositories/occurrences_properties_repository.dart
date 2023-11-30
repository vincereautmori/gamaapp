import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../entities/properties/properties_info.dart';

abstract class OccurrencesPropertiesRepository {
  Future<Result<OccurrencePropertiesInfo, Failure>> getProperties();
}
