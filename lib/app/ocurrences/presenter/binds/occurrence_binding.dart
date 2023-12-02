import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../shared/config/dio.dart';
import '../../domain/repositories/occurrences_repository.dart';
import '../../domain/usecases/create_occurrence/create_occurrence_usecase.dart';
import '../../domain/usecases/create_occurrence/create_occurrence_usecase_imp.dart';
import '../../domain/usecases/load_occurrence_data/load_occurrence_data_usecase.dart';
import '../../domain/usecases/load_occurrence_data/load_occurrence_data_usecase_imp.dart';
import '../../domain/usecases/start_occurrence/start_occurrence_usecase.dart';
import '../../domain/usecases/start_occurrence/start_occurrence_usecase_imp.dart';
import '../../domain/usecases/stop_occurrence/stop_occurrence_usecase.dart';
import '../../domain/usecases/stop_occurrence/stop_occurrence_usecase_imp.dart';
import '../../external/datasources/occurrences_datasource_imp.dart';
import '../../infra/datasources/occurrences_datasource.dart';
import '../../infra/repositories/occurrences_repository.dart';
import '../controllers/ocurrences_controller.dart';

class OccurrenceBinding implements Bindings {
  @override
  void dependencies() {
    Dio dio = Api().dio;

    OccurrencesDatasource datasource = OccurrencesDatasourceImp(dio);

    OccurrencesRepository repository = OccurrencesRepositoryImp(datasource);

    StartOccurrenceUsecase startOccurrence =
        StartOccurrenceUsecaseImp(repository);

    StopOccurrenceUsecase stopOccurrence = StopOccurrenceUsecaseImp(repository);

    CreateOccurrenceUsecase createOccurrence =
        CreateOccurrenceUsecaseImp(repository);

    LoadOccurrenceDataUsecase loadOccurrenceData =
        LoadOccurrenceDataUsecaseImp(repository);

    Get.lazyPut(
      () => OcurrencesController(
        startOccurrence: startOccurrence,
        stopOccurrence: stopOccurrence,
        createOccurrence: createOccurrence,
        loadOccurrenceData: loadOccurrenceData,
      ),
      fenix: true,
    );
  }
}
