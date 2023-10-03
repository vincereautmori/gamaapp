import '../models/traffic_violation_model.dart';

abstract class TrafficViolationDatasource {
  Future<List<TrafficViolationModel>> fetchTrafficViolations();
}
