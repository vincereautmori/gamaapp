import 'package:gamaapp/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';

import '../states/ocurrences_states.dart';

class OcurrencesController extends GetxController {
  List<OcurrencesInfo> get ocurrences => OcurrencyStates.ocurrences;

  void fillOcurrences(List<OcurrencesInfo> ocurrences) {
    OcurrencyStates.ocurrences.value = ocurrences;
  }

  void notifyNewOcurrency(OcurrencesInfo newOcurrecy) {
    utils.callSnackBar(
      title: "Nova ocorrência cadastrada",
      message:
          "Uma nova ocorrência surgiu em suas proximidades - ${newOcurrecy.occurrenceId}",
      snackPosition: SnackPosition.TOP,
    );
  }
}
