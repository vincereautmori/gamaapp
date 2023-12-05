import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../shared/config/dio.dart';
import '../../domain/repositories/occurrences_properties_repository.dart';
import '../../domain/usecases/get_properties/get_properties_usecase.dart';
import '../../domain/usecases/get_properties/get_properties_usecase_imp.dart';
import '../../external/datasources/occurrences_properties_datasource_imp.dart';
import '../../infra/datasources/occurrence_properties_datasource.dart';
import '../../infra/repositories/occurrences_properties_repository.dart';
import '../controllers/occurrences_properties_controller.dart';

class OccurrencePropertiesBinding implements Bindings {
  @override
  void dependencies() {
    Dio dio = Api().dio;

    OccurrencesPropertiesDatasource propertiesDatasource =
        OccurrencesPropertiesDatasourceImp(dio);

    OccurrencesPropertiesRepository propertiesRepository =
        OccurrencesPropertiesRepositoryImp(propertiesDatasource);

    GetPropertiesUsecase getPropertiesUsecase =
        GetPropertiesUsecaseImp(propertiesRepository);

    Get.lazyPut(() => OccurrencesPropertiesController(getPropertiesUsecase),
        fenix: true);
  }
}
