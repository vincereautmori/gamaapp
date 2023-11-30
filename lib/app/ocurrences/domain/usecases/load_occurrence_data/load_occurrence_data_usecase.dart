import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/ocurrences/ocurrences_info.dart';

abstract class LoadOccurrenceDataUsecase {
  Future<Result<OccurrencesInfo, Failure>> call(int id);
}
