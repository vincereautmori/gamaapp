import 'package:equatable/equatable.dart';
import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';

class TrafficFineEntity extends Equatable {
  final int id;
  final String licensePlate;
  final double latitude;
  final double longitude;
  final bool active;
  final bool computed;
  final String imageUrl;
  final bool deleted;
  final DateTime createdAt;
  final List<TrafficViolationInfo> trafficViolations;

  const TrafficFineEntity({
    required this.id,
    required this.licensePlate,
    required this.latitude,
    required this.longitude,
    required this.active,
    required this.computed,
    this.imageUrl = "",
    required this.deleted,
    required this.createdAt,
    this.trafficViolations = const [],
  });

  @override
  List get props => [
        id,
        licensePlate,
        latitude,
        longitude,
        active,
        computed,
        imageUrl,
        deleted,
        createdAt,
        trafficViolations,
      ];
}
