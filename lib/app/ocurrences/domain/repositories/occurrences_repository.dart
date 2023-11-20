import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';

abstract class OccurrencesRepository {
  Future<Result<Unit, Failure>> startOccurrence(int occurrenceId);
  Future<Result<Unit, Failure>> stopOccurrence(int occurrenceId);
  Future<Result<Unit, Failure>> createOccurrence(
    double latitude,
    double longitude,
    String location,
    String name,
    String description,
    int occurrenceStatusId,
    int occurrenceTypeId,
    int occurrenceUrgencyLevelId,
    String imageUrl,
  );
}
