import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';

abstract class OccurrencesDatasource {
  Future<void> startOccurrence(int occurrenceId);
  Future<void> stopOccurrence(int occurrenceId);
  Future<void> createOccurrence(
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
  Future<OccurrencesInfo> getOccurrenceById(int occurrenceId);
}
