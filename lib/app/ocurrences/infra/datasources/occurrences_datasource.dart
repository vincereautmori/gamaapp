abstract class OccurrencesDatasource {
  Future<void> startOccurrence(int occurrenceId);
  Future<void> stopOccurrence(int occurrenceId);
}
