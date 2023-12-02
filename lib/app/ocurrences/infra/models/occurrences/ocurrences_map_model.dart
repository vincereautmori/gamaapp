import '../../../domain/entities/ocurrences/occurrences_map_entity.dart';
import '../../../domain/entities/ocurrences/occurrences_map_info.dart';

class OcurrencesMapModel extends OccurrencesMapEntity
    implements OccurrencesMapInfo {
  const OcurrencesMapModel({
    required super.createdAt,
    required super.name,
    required super.occurrenceId,
    required super.latitude,
    required super.longitude,
    required super.location,
    required super.occurrenceName,
    required super.statusName,
    required super.occurrenceUrgencyLevelName,
    required super.occurrenceTypeName,
    required super.userId,
    required super.userName,
    required super.active,
  });

  factory OcurrencesMapModel.fromJson(Map<String, dynamic> json) =>
      OcurrencesMapModel(
        latitude: json['point']['latitude'],
        longitude: json['point']['longitude'],
        createdAt: DateTime.parse(json['message']['createdAt']),
        name: json['message']['name'] ?? "",
        occurrenceId: json['message']['occurrenceId'],
        location: json['message']['location'] ?? "",
        occurrenceName: json['message']['occurrenceName'],
        statusName: json['message']['statusName'] ?? "",
        occurrenceUrgencyLevelName:
            json['message']['occurrenceUrgencyLevelName'] ?? "",
        occurrenceTypeName: json['message']['occurrenceTypeName'] ?? "",
        userId: json['message']['userId'],
        userName: json['message']['userName'] ?? "",
        active: json['message']['active'],
      );

  static List<OcurrencesMapModel> fromJsonList(List jsonList) =>
      List<OcurrencesMapModel>.from(
        jsonList.map(
          (json) => OcurrencesMapModel.fromJson(json),
        ),
      );
}
