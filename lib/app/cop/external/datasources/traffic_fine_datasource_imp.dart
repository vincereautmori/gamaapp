import 'package:dio/dio.dart';

import '/app/cop/infra/datasources/traffic_fine_datasource.dart';
import '/app/cop/infra/models/listed_traffic_fine_model.dart';

class TrafficFineDatasourceImp implements TrafficFineDatasource {
  final Dio dio;

  TrafficFineDatasourceImp(this.dio);

  @override
  Future<List<ListedTrafficFineModel>> fetchTrafficFines({
    String? createdSince,
    String? createdUntil,
  }) async {
    Map<String, dynamic>? params = {};

    if (createdSince != null) {
      params["createdSince"] = createdSince;
    }

    if (createdUntil != null) {
      params["createdUntil"] = createdUntil;
    }

    Response res = await dio.get('/traffic-fines', queryParameters: params);

    List<ListedTrafficFineModel> trafficModels = res.data['results']
        .map<ListedTrafficFineModel>(
          (trafficFine) => ListedTrafficFineModel(
            id: trafficFine['id'],
            computed: trafficFine['computed'],
            createdAt: DateTime.parse(trafficFine['createdAt']),
            licensePlate: trafficFine['licensePlate'],
          ),
        )
        .toList();

    return trafficModels;
  }
}
