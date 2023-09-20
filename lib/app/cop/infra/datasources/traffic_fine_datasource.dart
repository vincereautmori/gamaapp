import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';

import '../../domain/entities/trafficFine/traffic_fine_info.dart';

abstract class TrafficFineDatasource {
  Future<List<ListedTrafficFineModel>> fetchTrafficFines({
    String? createdSince,
    String? createdUntil,
  });

  Future<TrafficFineInfo> createTrafficFine({
    required String licensePlate,
    required double latitude,
    required double longitude,
    required List<Map<String, int>> trafficViolations,
    required String imageUrl,
  });
}
