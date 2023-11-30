import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class StartOccurrenceUsecase {
  Future<Result<Unit, Failure>> call(int occurrenceId);
}
