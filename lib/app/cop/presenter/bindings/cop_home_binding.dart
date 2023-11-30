import 'package:dio/dio.dart';
import 'package:gamaapp/app/ocurrences/domain/usecases/get_properties/get_properties_usecase.dart';
import 'package:gamaapp/app/ocurrences/domain/usecases/load_occurrence_data/load_occurrence_data_usecase.dart';
import 'package:gamaapp/app/ocurrences/infra/datasources/occurrence_properties_datasource.dart';
import 'package:gamaapp/app/ocurrences/infra/repositories/occurrences_properties_repository.dart';
import 'package:get/get.dart';

import '../../../ocurrences/domain/repositories/occurrences_properties_repository.dart';
import '../../../ocurrences/domain/usecases/create_occurrence/create_occurrence_usecase.dart';
import '../../../ocurrences/domain/usecases/create_occurrence/create_occurrence_usecase_imp.dart';
import '../../../ocurrences/domain/usecases/get_properties/get_properties_usecase_imp.dart';
import '../../../ocurrences/domain/usecases/load_occurrence_data/load_occurrence_data_usecase_imp.dart';
import '../../../ocurrences/external/datasources/occurrences_properties_datasource_imp.dart';
import '../../../ocurrences/presenter/controllers/occurrences_properties_controller.dart';
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
    OccurrencesPropertiesDatasource propertiesDatasource =
        OccurrencesPropertiesDatasourceImp(dio);

    OccurrencesRepository repository = OccurrencesRepositoryImp(datasource);
    OccurrencesPropertiesRepository propertiesRepository =
        OccurrencesPropertiesRepositoryImp(propertiesDatasource);

    StartOccurrenceUsecase startOccurrence =
        StartOccurrenceUsecaseImp(repository);
    StopOccurrenceUsecase stopOccurrence = StopOccurrenceUsecaseImp(repository);
    CreateOccurrenceUsecase createOccurrence =
        CreateOccurrenceUsecaseImp(repository);

    GetPropertiesUsecase getPropertiesUsecase =
        GetPropertiesUsecaseImp(propertiesRepository);

    LoadOccurrenceDataUsecase loadOccurrenceData =
        LoadOccurrenceDataUsecaseImp(repository);

    Get.lazyPut(() => CopHomeController(), fenix: true);
    Get.lazyPut(() => OccurrencesPropertiesController(getPropertiesUsecase),
        fenix: true);
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
