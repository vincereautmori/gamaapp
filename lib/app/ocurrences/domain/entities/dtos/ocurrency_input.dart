class OccurrenceInput {
  final double latitude;
  final double longitude;
  final String location;
  final String name;
  final String description;
  final int occurrenceStatusId;
  final int occurrenceTypeId;
  final int occurrenceUrgencyLevelId;
  final String imageUrl;

  OccurrenceInput({
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

  OccurrenceInput copyWith({
    double? latitude,
    double? longitude,
    String? location,
    String? name,
    String? description,
    int? occurrenceStatusId,
    int? occurrenceTypeId,
    int? occurrenceUrgencyLevelId,
    String? imageUrl,
  }) =>
      OccurrenceInput(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        location: location ?? this.location,
        name: name ?? this.name,
        description: description ?? this.description,
        occurrenceStatusId: occurrenceStatusId ?? this.occurrenceStatusId,
        occurrenceTypeId: occurrenceTypeId ?? this.occurrenceTypeId,
        occurrenceUrgencyLevelId:
            occurrenceUrgencyLevelId ?? this.occurrenceUrgencyLevelId,
        imageUrl: imageUrl ?? this.imageUrl,
      );
}
