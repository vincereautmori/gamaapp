import '../../../domain/entities/properties/properties_entity.dart';
import '../../../domain/entities/properties/properties_info.dart';

class OccurrencePropertiesModel extends OccurrencePropertiesEntity
    implements OccurrencePropertiesInfo {
  const OccurrencePropertiesModel({
    required super.urgencyLevels,
    required super.types,
    required super.status,
  });

  factory OccurrencePropertiesModel.fromJson(Map<String, dynamic> json) =>
      OccurrencePropertiesModel(
        status: PropertiesInfo.fromListJson(json['status']),
        types: PropertiesInfo.fromListJson(json['types']),
        urgencyLevels: PropertiesInfo.fromListJson(json['urgencyLevels']),
      );

  List<PropertiesInfo> resolveProperties(List propertiesJsonList) => List.from(
        propertiesJsonList.map(
          (json) => PropertiesInfo.fromJson(json),
        ),
      );
}
