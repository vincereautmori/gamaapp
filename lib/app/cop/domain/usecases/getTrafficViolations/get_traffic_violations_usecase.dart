import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../auth/domain/errors/errors.dart';

abstract class GetTrafficViolationsUsecase {
  Future<Result<List<TrafficViolationInfo>, Failure>> call();
}
