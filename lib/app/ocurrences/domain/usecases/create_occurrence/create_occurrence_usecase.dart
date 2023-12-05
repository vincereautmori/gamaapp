import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';
import '../../entities/dtos/occurrence_input.dart';

abstract class CreateOccurrenceUsecase {
  Future<Result<Unit, Failure>> call(OccurrenceInput input);
}
