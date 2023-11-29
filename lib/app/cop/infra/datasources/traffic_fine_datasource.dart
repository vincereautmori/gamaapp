import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';
import 'package:gamaapp/app/cop/infra/models/traffic_fine_model.dart';

abstract class TrafficFineDatasource {
  Future<TrafficFineModel?> getTrafficFine(int id);

  Future<List<ListedTrafficFineModel>> fetchTrafficFines({
    String? licensePlate,
    String? createdSince,
    String? createdUntil,
    required int size,
    required int pageNumber,
  });

  Future<int> createTrafficFine({
    required String licensePlate,
    required double latitude,
    required double longitude,
    required List<Map<String, int>> trafficViolations,
    required String imageUrl,
  });
}
