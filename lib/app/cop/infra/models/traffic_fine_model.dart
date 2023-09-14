import '/app/cop/domain/entities/trafficFine/traffic_fina_info.dart';
import '/app/cop/domain/entities/trafficFine/traffic_fine_entity.dart';

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
  });
}