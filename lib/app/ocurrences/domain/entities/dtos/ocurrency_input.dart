class OcurrenceInput {
  final double latitude;
  final double longitude;
  final String location;
  final String name;
  final String description;
  final int occurrenceStatusId;
  final int occurrenceTypeId;
  final int occurrenceUrgencyLevelId;
  final String imageUrl;

  OcurrenceInput({
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.name,
    required this.description,
    required this.occurrenceStatusId,
    required this.occurrenceTypeId,
    required this.occurrenceUrgencyLevelId,
    required this.imageUrl,
  });
}
