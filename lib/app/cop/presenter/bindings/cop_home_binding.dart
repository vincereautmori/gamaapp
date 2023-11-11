import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '/app/cop/presenter/controllers/cop_home_controller.dart';
import '/app/ocurrences/domain/repositories/occurrences_repository.dart';
import '/app/ocurrences/domain/usecases/start_occurrence/start_occurrence_usecase.dart';
import '/app/ocurrences/domain/usecases/start_occurrence/start_occurrence_usecase_imp.dart';
import '/app/ocurrences/domain/usecases/stop_occurrence/stop_occurrence_usecase.dart';
import '/app/ocurrences/domain/usecases/stop_occurrence/stop_occurrence_usecase_imp.dart';
import '/app/ocurrences/external/datasources/occurrences_datasource_imp.dart';
import '/app/ocurrences/infra/datasources/occurrences_datasource.dart';
import '/app/ocurrences/infra/repositories/occurrences_repository.dart';
import '/app/ocurrences/presenter/controllers/ocurrences_controller.dart';
import '/shared/config/dio.dart';

class CopHomeBinding extends Bindings {
  @override
  void dependencies() {
    Dio dio = Api().dio;

    OccurrencesDatasource datasource = OccurrencesDatasourceImp(dio);

    OccurrencesRepository repository = OccurrencesRepositoryImp(datasource);

    StartOccurrenceUsecase startOccurrence =
        StartOccurrenceUsecaseImp(repository);
    StopOccurrenceUsecase stopOccurrence = StopOccurrenceUsecaseImp(repository);

    Get.lazyPut(() => CopHomeController(), fenix: true);
    Get.lazyPut(
      () => OcurrencesController(
        startOccurrence: startOccurrence,
        stopOccurrence: stopOccurrence,
      ),
      fenix: true,
    );
  }
}
