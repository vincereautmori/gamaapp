import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '/app/auth/domain/errors/errors.dart';

abstract class TrafficViolationRepository {
  Future<Result<List<TrafficViolationInfo>, Failure>> fetchTrafficViolation();
}
