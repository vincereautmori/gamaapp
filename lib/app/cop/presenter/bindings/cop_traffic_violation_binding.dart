import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/app/auth/external/providers/auth_provider.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_violation_repository.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficViolations/get_traffic_violations_usecase.dart';
import 'package:gamaapp/app/cop/infra/datasources/traffic_violation_datasource.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_violation_controller.dart';
import 'package:get/get.dart';

import '../../../../shared/config/dio.dart';
import '../../domain/usecases/getTrafficViolations/get_traffic_violations_usecase_imp.dart';
import '../../external/datasources/traffic_violation_datasource_imp.dart';
import '../../infra/repositories/traffic_violation_repository_imp.dart';

class CopTrafficViolationBinding implements Bindings {
  final authorizationProvider = AuthorizationProvider(
    const FlutterSecureStorage(),
  );

  @override
  void dependencies() {
    Dio dio = Api().dio;

    TrafficViolationDatasource datasource = TrafficViolationDatasourceImp(dio);

    TrafficViolationRepository repository =
        TrafficViolationRepositoryImp(datasource);

    GetTrafficViolationsUsecase usecase =
        GetTrafficViolationsUsecaseImp(repository);

    Get.lazyPut(
      () => CopTrafficViolationController(usecase),
      fenix: true,
    );
  }
}
