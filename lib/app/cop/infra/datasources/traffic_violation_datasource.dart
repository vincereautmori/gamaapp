import '../models/traffic_violation_model.dart';

abstract class TrafficFineDatasource {
  Future<List<TrafficViolationModel>> fetchTrafficViolations();
}
