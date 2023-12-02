import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../auth/domain/errors/errors.dart';
import '../entities/ocurrences/listed_occurrences_info.dart';

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

  Future<Result<OccurrencesInfo, Failure>> getOccurrenceById(int id);
  Future<Result<List<ListedOccurrencesInfo>, Failure>> getOccurrences({
    String? createdSince,
    String? createdUntil,
    required int size,
    required int pageNumber,
  });
}
