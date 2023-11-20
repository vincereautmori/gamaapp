import 'package:gamaapp/shared/utils/utils.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/usecases/create_occurrence/create_occurrence_usecase.dart';
import '../../domain/usecases/stop_occurrence/stop_occurrence_usecase.dart';
import '../states/ocurrences_states.dart';
import '/app/ocurrences/domain/entities/ocurrences/ocurrences_info.dart';
import '/app/ocurrences/domain/usecases/start_occurrence/start_occurrence_usecase.dart';
import '/app/routes/routes_name.dart';

class OcurrencesController extends GetxController {
  final StartOccurrenceUsecase startOccurrence;
  final StopOccurrenceUsecase stopOccurrence;
  final CreateOccurrenceUsecase createOccurrence;

  OcurrencesController({
    required this.startOccurrence,
    required this.stopOccurrence,
    required this.createOccurrence,
  });

  List<OccurrencesInfo> get occurrences => OccurrenceStates.ocurrences;

  OccurrencesInfo? get openedOccurrence =>
      OccurrenceStates.openedOcurrence.value;

  OccurrencesInfo? get startedOccurrence =>
      OccurrenceStates.startedOccurrence.value;

  void fillOccurrences(List<OccurrencesInfo> occurrences) {
    OccurrenceStates.ocurrences.value = occurrences;
  }

  void notifyNewOccurrence(OccurrencesInfo newOccurrence) {
    bool ocurrenceAlreadyExist = occurrences.any(
      (ocurrence) => ocurrence.occurrenceId == newOccurrence.occurrenceId,
    );

    if (!ocurrenceAlreadyExist) {
      occurrences.add(newOccurrence);

      utils.callSnackBar(
        title: "Nova ocorrência cadastrada",
        message:
            "Uma nova ocorrência surgiu em suas proximidades - ${newOccurrence.occurrenceId}",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  void viewOccurrence(OccurrencesInfo ocurrence) {
    OccurrenceStates.openedOcurrence.value = ocurrence;
    Get.toNamed(RoutesNames.viewOccurrence);
  }

  void start(OccurrencesInfo occurrence) async {
    Result result = await startOccurrence(occurrence.occurrenceId);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = occurrence;
      utils.callSnackBar(
        title: "Iniciado ocorrência",
        message: "Ocorrência ${occurrence.occurrenceId} iniciada com sucesso",
      );
    },
        (error) => utils.callSnackBar(
              title: "Falha ao iniciar ocorrência",
              message: error.message,
            ));
  }

  void stop(OccurrencesInfo occurrence) async {
    Result result = await stopOccurrence(occurrence.occurrenceId);
    result.when((_) {
      OccurrenceStates.startedOccurrence.value = null;
      utils.callSnackBar(
        title: "Ocorrência finalizada",
        message: "Ocorrência ${occurrence.occurrenceId} finalizada com sucesso",
      );
    },
        (error) => utils.callSnackBar(
              title: "Falha ao finalizar ocorrência",
              message: error.message,
            ));
  }
}
