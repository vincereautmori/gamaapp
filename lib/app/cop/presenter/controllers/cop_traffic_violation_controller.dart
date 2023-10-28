import 'package:gamaapp/app/cop/domain/entities/trafficViolations/traffic_violation_info.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficViolations/get_traffic_violations_usecase.dart';
import 'package:gamaapp/app/cop/presenter/states/traffic_violation_states.dart';
import 'package:gamaapp/shared/utils/loading.dart';
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

  bool get allViolationsChecked => TrafficViolationStates.allChecked.value;

  bool get isLoading =>
      LoadingHandler.loadingState.value ==
      LoadingStates.loadingTrafficViolations;

  CopTrafficViolationController(this.getTrafficViolations);

  Future<void> getAllViolations() async {
    LoadingHandler.setLoading(LoadingStates.loadingTrafficViolations);
    Result result = await getTrafficViolations();
    LoadingHandler.stopLoading();

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

  void handleCheckAll() {
    if (allViolationsChecked) {
      selectedTrafficViolations.clear();
    } else {
      selectedTrafficViolations.addAll(trafficViolations);
    }
    TrafficViolationStates.allChecked.toggle();
  }

  void selectViolation(TrafficViolationInfo violation) =>
      selectedTrafficViolations.add(violation);

  void unselectViolation(TrafficViolationInfo violation) {
    selectedTrafficViolations.remove(violation);
    if (selectedTrafficViolations.isEmpty) {
      TrafficViolationStates.allChecked.value = false;
    }
  }
}
