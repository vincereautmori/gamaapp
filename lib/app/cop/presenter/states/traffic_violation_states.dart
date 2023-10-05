import 'package:get/get.dart';

import '../../domain/entities/trafficViolations/traffic_violation_info.dart';

class TrafficViolationStates {
  static final RxList<TrafficViolationInfo> trafficViolations =
      <TrafficViolationInfo>[].obs;

  static final RxSet<TrafficViolationInfo> selectedTrafficViolations =
      <TrafficViolationInfo>{}.obs;
}
