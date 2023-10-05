import 'package:dio/dio.dart';
import 'package:gamaapp/app/cop/infra/models/traffic_violation_model.dart';

import '../../infra/datasources/traffic_violation_datasource.dart';

class TrafficViolationDatasourceImp implements TrafficViolationDatasource {
  final Dio dio;

  TrafficViolationDatasourceImp(this.dio);

  @override
  Future<List<TrafficViolationModel>> fetchTrafficViolations() async {
    Response res = await dio.get('/traffic-violations');
    print(res.data);
    List<TrafficViolationModel> trafficViolations =
        TrafficViolationModel.fromJsonList(res.data);

    return trafficViolations;
  }
}
