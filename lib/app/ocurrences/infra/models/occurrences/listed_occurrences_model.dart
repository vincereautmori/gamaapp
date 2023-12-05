import '../../../domain/entities/ocurrences/listed_occurrences_entity.dart';
import '../../../domain/entities/ocurrences/listed_occurrences_info.dart';

class ListedOccurrencesModel extends ListedOccurrencesEntity
    implements ListedOccurrencesInfo {
  const ListedOccurrencesModel({
    required super.id,
    required super.name,
    required super.description,
    required super.occurrenceUrgencyLevel,
    required super.occurrenceType,
    required super.status,
    required super.active,
    required super.pageNumber,
  });

  factory ListedOccurrencesModel.fromJson(
          Map<String, dynamic> json, int pageAt) =>
      ListedOccurrencesModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        occurrenceUrgencyLevel: json["occurrenceUrgencyLevel"],
        occurrenceType: json["occurrenceType"],
        status: json["status"],
        active: json["active"],
        pageNumber: pageAt,
      );

  static List<ListedOccurrencesModel> fromListJson(List jsonList, int pageAt) =>
      List.from(
        jsonList.map(
          (json) => ListedOccurrencesModel.fromJson(json, pageAt),
        ),
      );
}
