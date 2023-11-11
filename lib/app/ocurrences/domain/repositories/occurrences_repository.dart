import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';

abstract class OccurrencesRepository {
  Future<Result<Unit, Failure>> startOccurrence(int occurrenceId);
  Future<Result<Unit, Failure>> stopOccurrence(int occurrenceId);
}
