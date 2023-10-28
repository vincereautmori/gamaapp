import 'package:dio/dio.dart';
import 'package:gamaapp/app/cop/infra/models/traffic_fine_model.dart';
import 'package:gamaapp/app/cop/presenter/states/traffic_fine_states.dart';

import '/app/cop/infra/datasources/traffic_fine_datasource.dart';
import '/app/cop/infra/models/listed_traffic_fine_model.dart';

class TrafficFineDatasourceImp implements TrafficFineDatasource {
  final Dio dio;

  TrafficFineDatasourceImp(this.dio);

  @override
  Future<TrafficFineModel?> getTrafficFine(int id) async {
    Response res = await dio.get('/traffic-fines/$id');
    if (res.statusCode != 200) return null;
    return TrafficFineModel.fromJson(res.data);
  }

  @override
  Future<List<ListedTrafficFineModel>> fetchTrafficFines({
    String? licensePlate,
    String? createdSince,
    String? createdUntil,
    required int size,
    required int pageNumber,
  }) async {
    Map<String, dynamic>? params = {
      "licensePlate": licensePlate,
      "size": size,
      "pageNumber": pageNumber,
    };

    if (createdSince != null) {
      params["createdSince"] = createdSince;
    }

    if (createdUntil != null) {
      params["createdUntil"] = createdUntil;
    }

    Response res = await dio.get('/traffic-fines', queryParameters: params);

    int pageAt = res.data['pageNumber'];

    TrafficFineStates.pagination.value =
        TrafficFineStates.pagination.value.copyWith(count: res.data['count']);

    List<ListedTrafficFineModel> trafficModels = res.data['results']
        .map<ListedTrafficFineModel>(
          (trafficFine) => ListedTrafficFineModel(
            id: trafficFine['id'],
            computed: trafficFine['computed'],
            createdAt: DateTime.parse(trafficFine['createdAt']),
            licensePlate: trafficFine['licensePlate'],
            pageNumber: pageAt,
          ),
        )
        .toList();

    return trafficModels;
  }

  @override
  Future<int> createTrafficFine({
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

    return res.statusCode ?? 500;
  }

  @override
  Future<String> uploadImage(FormData fileFormData) async {
    Response response = await dio.post(
      '/files',
      data: fileFormData,
      onSendProgress: (count, total) {
        TrafficFineStates.trafficFineImageBytesCount.value = count;
        TrafficFineStates.trafficFineImageBytesTotal.value = total;
      },
    );

    return response.data;
  }
}
