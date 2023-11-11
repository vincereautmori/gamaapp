import '../../../domain/entities/ocurrences/ocurrences_entity.dart';
import '../../../domain/entities/ocurrences/ocurrences_info.dart';

class OcurrencesModel extends OcurrencesEntity implements OccurrencesInfo {
  const OcurrencesModel({
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

  factory OcurrencesModel.fromJson(Map<String, dynamic> json) =>
      OcurrencesModel(
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

  static List<OcurrencesModel> fromJsonList(List jsonList) =>
      List<OcurrencesModel>.from(
        jsonList.map(
          (json) => OcurrencesModel.fromJson(json),
        ),
      );
}
