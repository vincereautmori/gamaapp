import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class StopOccurrenceUsecase {
  Future<Result<Unit, Failure>> call(int occurrenceId);
}
