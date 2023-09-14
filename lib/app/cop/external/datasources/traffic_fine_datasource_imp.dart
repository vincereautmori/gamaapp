import 'package:dio/dio.dart';

import '/app/cop/infra/datasources/traffic_fine_datasource.dart';
import '/app/cop/infra/models/listed_traffic_fine_model.dart';

class TrafficFineDatasourceImp implements TrafficFineDatasource {
  final Dio dio;

  TrafficFineDatasourceImp(this.dio);

  @override
  Future<List<ListedTrafficFineModel>> fetchTrafficFines(
      {String? createdSince, String? createdUntil}) {
    // TODO: implement fetchTrafficFines
    throw UnimplementedError();
  }
}
