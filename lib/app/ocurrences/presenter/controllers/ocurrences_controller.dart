import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:gamaapp/app/routes/routes_name.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';

import '../states/ocurrences_states.dart';

class OcurrencesController extends GetxController {
  List<OcurrencesInfo> get ocurrences => OcurrenceStates.ocurrences;

  OcurrencesInfo? get openedOcurrence => OcurrenceStates.openedOcurrence.value;

  bool get isInOccurrence => OcurrenceStates.isInOccurrence.value;

  void fillOcurrences(List<OcurrencesInfo> ocurrences) {
    OcurrenceStates.ocurrences.value = ocurrences;
  }

  void notifyNewOcurrence(OcurrencesInfo newOcurrence) {
    bool ocurrenceAlreadyExist = ocurrences.any(
      (ocurrence) => ocurrence.occurrenceId == newOcurrence.occurrenceId,
    );

    if (!ocurrenceAlreadyExist) {
      ocurrences.add(newOcurrence);

      utils.callSnackBar(
        title: "Nova ocorrência cadastrada",
        message:
            "Uma nova ocorrência surgiu em suas proximidades - ${newOcurrence.occurrenceId}",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void viewOcurrence(OcurrencesInfo ocurrence) {
    OcurrenceStates.openedOcurrence.value = ocurrence;
    Get.toNamed(RoutesNames.viewOcurrence);
  }
}
