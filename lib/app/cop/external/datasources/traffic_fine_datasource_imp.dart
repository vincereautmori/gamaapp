import 'package:dio/dio.dart';

import '/app/cop/infra/datasources/traffic_fine_datasource.dart';
import '/app/cop/infra/models/listed_traffic_fine_model.dart';
import '../../infra/models/traffic_fine_model.dart';

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

  @override
  Future<TrafficFineModel> createTrafficFine({
    required String licensePlate,
    required double latitude,
    required double longitude,
    required List<Map<String, int>> trafficViolations,
    required String imageUrl,
  }) async {
    Response res = await dio.post('/traffic-fines', data: {
      "licensePlate": licensePlate,
      "latitude": latitude,
      "longitude": longitude,
      "trafficViolations": trafficViolations,
      "imageUrl": imageUrl,
    });

    TrafficFineModel trafficFine =
        TrafficFineModel.fromJson(res.data['response']);
    return trafficFine;
  }

  @override
  Future<String> uploadImage(FormData fileFormData) async {
    Response response = await dio.post(
      '/files',
      data: fileFormData,
    );

    return response.data;
  }
}
