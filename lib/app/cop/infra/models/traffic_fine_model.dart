import '/app/cop/domain/entities/trafficFine/traffic_fine_entity.dart';
import '../../domain/entities/trafficFine/traffic_fine_info.dart';
import '../../domain/entities/trafficViolations/traffic_violation_info.dart';
import 'traffic_violation_model.dart';

class TrafficFineModel extends TrafficFineEntity implements TrafficFineInfo {
  const TrafficFineModel({
    required super.id,
    required super.licensePlate,
    required super.latitude,
    required super.longitude,
    required super.active,
    required super.computed,
    required super.imageUrl,
    required super.deleted,
    required super.createdAt,
    required super.trafficViolations,
  });

  static TrafficFineModel fromJson(Map<String, dynamic> json) =>
      TrafficFineModel(
        active: json['active'],
        computed: json['computed'],
        createdAt: DateTime.parse(json['createdAt']),
        trafficViolations: List<TrafficViolationInfo>.from(
          json['trafficViolations'].map<TrafficViolationInfo>(
            (violation) => TrafficViolationModel.fromJson(violation),
          ),
        ),
        deleted: json['deleted'],
        id: json['id'],
        imageUrl: json['imageUrl'],
        latitude: json['latitude'],
        licensePlate: json['licensePlate'],
        longitude: json['longitude'],
      );
}
