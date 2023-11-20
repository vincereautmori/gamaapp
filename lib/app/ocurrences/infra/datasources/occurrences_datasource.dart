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
}
