import 'package:dio/dio.dart';
import 'package:gamaapp/app/cop/infra/models/listed_traffic_fine_model.dart';

import '../models/traffic_fine_model.dart';

abstract class TrafficFineDatasource {
  Future<List<ListedTrafficFineModel>> fetchTrafficFines({
    String? createdSince,
    String? createdUntil,
  });

  Future<TrafficFineModel> createTrafficFine({
    required String licensePlate,
    required double latitude,
    required double longitude,
    required List<Map<String, int>> trafficViolations,
    required String imageUrl,
  });

  Future<String> uploadImage(FormData fileFormData);
}
