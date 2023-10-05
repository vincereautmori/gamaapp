import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/app/auth/external/providers/auth_provider.dart';
import 'package:gamaapp/app/cop/domain/repositories/traffic_violation_repository.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficViolations/get_traffic_violations_usecase.dart';
import 'package:gamaapp/app/cop/infra/datasources/traffic_violation_datasource.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_violation_controller.dart';
import 'package:get/get.dart';

import '../../../../shared/config/config.dart';
import '../../domain/usecases/getTrafficViolations/get_traffic_violations_usecase_imp.dart';
import '../../external/datasources/traffic_violation_datasource_imp.dart';
import '../../infra/repositories/traffic_violation_repository_imp.dart';

class CopTrafficViolationBinding implements Bindings {
  final authorizationProvider = AuthorizationProvider(
    const FlutterSecureStorage(),
  );

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Config.coreApiUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ),
  );
  @override
  void dependencies() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await authorizationProvider.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
    ));

    TrafficViolationDatasource datasource = TrafficViolationDatasourceImp(_dio);

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
