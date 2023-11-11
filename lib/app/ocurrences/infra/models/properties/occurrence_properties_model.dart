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
        status: json['a'],
        types: json['a'],
        urgencyLevels: json['a'],
      );

  List<PropertiesInfo> resolveProperties(List propertiesJsonList) => List.from(
        propertiesJsonList.map(
          (json) => PropertiesInfo.fromJson(json),
        ),
      );
}
