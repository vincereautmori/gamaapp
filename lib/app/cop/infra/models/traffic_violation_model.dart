import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';

import '../../domain/entities/trafficViolations/traffic_violation_entity.dart';

class TrafficViolationModel extends TrafficViolationEntity
    implements TrafficViolationInfo {
  const TrafficViolationModel({
    required super.id,
    required super.code,
    required super.name,
    required super.active,
  });

  static TrafficViolationModel fromJson(Map<String, dynamic> json) =>
      TrafficViolationModel(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        active: json['active'],
      );

  static List<TrafficViolationModel> fromJsonList(
          List<Map<String, dynamic>> jsonList) =>
      List<TrafficViolationModel>.from(
        jsonList.map(
          (json) => fromJson(json),
        ),
      );
}
