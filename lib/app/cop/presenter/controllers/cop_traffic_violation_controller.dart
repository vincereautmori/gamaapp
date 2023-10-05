import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficViolations/get_traffic_violations_usecase.dart';
import 'package:gamaapp/app/cop/presenter/states/traffic_violation_states.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

class CopTrafficViolationController extends GetxController {
  final GetTrafficViolationsUsecase getTrafficViolations;

  List<TrafficViolationInfo> get trafficViolations =>
      TrafficViolationStates.trafficViolations;

  CopTrafficViolationController(this.getTrafficViolations);

  Future<void> getAllViolations() async {
    Result result = await getTrafficViolations();
    result.when((violations) {
      print(violations);
      TrafficViolationStates.trafficViolations.value = violations;
    }, (error) {
      print(error);
    });
  }
}
