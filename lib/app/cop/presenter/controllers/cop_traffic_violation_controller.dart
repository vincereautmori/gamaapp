import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficViolations/get_traffic_violations_usecase.dart';
import 'package:gamaapp/app/cop/presenter/states/traffic_violation_states.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../../shared/themes/snackbar_styles.dart';
import '../../../../shared/utils/utils.dart';

class CopTrafficViolationController extends GetxController {
  final GetTrafficViolationsUsecase getTrafficViolations;

  List<TrafficViolationInfo> get trafficViolations =>
      TrafficViolationStates.trafficViolations;

  Set<TrafficViolationInfo> get selectedTrafficViolations =>
      TrafficViolationStates.selectedTrafficViolations;

  CopTrafficViolationController(this.getTrafficViolations);

  Future<void> getAllViolations() async {
    Result result = await getTrafficViolations();
    result.when((violations) {
      TrafficViolationStates.trafficViolations.value = violations;
    }, (error) {
      utils.callSnackBar(
        title: "Falha ao carregar violações",
        message: error.message,
        snackStyle: SnackBarStyles.error,
      );
    });
  }

  void selectViolation(TrafficViolationInfo violation) =>
      TrafficViolationStates.selectedTrafficViolations.add(violation);

  void unselectViolation(TrafficViolationInfo violation) =>
      TrafficViolationStates.selectedTrafficViolations.remove(violation);
}
