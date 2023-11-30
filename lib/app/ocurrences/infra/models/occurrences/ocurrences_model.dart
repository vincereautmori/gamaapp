import '../../../domain/entities/ocurrences/ocurrences_entity.dart';
import '../../../domain/entities/ocurrences/ocurrences_info.dart';

class OcurrencesModel extends OcurrencesEntity implements OccurrencesInfo {
  const OcurrencesModel({
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.location,
    required super.status,
    required super.urgencyLevel,
    required super.occurrenceType,
    required super.userId,
    required super.description,
    required super.imageUrl,
    required super.active,
  });

  factory OcurrencesModel.fromJson(Map<String, dynamic> json) =>
      OcurrencesModel(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        name: json['name'] ?? "",
        location: json['location'] ?? "",
        status: json['status'] ?? "",
        urgencyLevel: json['urgencyLevel'] ?? "",
        imageUrl: json['imageUrl'],
        description: json['description'],
        occurrenceType: json['occurrenceType'] ?? "",
        userId: json['userId'],
        active: json['active'],
      );
}
