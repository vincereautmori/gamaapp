import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/app/auth/external/providers/auth_provider.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';
import 'package:gamaapp/app/cop/domain/usecases/uploadFile/upload_file_usecase_imp.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:get/get.dart';

import '../../../../shared/config/config.dart';
import '../../domain/repositories/traffic_fine_repository.dart';
import '../../domain/usecases/getAllTrafficFines/get_all_traffic_fine_usecase.dart';
import '../../domain/usecases/getAllTrafficFines/get_all_traffic_fine_usecase_imp.dart';
import '../../domain/usecases/getTrafficFine/get_traffic_fine_usecase_imp.dart';
import '../../domain/usecases/saveTrafficFine/save_traffic_usecase.dart';
import '../../domain/usecases/saveTrafficFine/save_traffic_usecase_imp.dart';
import '../../domain/usecases/uploadFile/upload_file_usecase.dart';
import '../../external/datasources/traffic_fine_datasource_imp.dart';
import '../../infra/datasources/traffic_fine_datasource.dart';
import '../../infra/repositories/traffic_fine_repository_imp.dart';

class CopTrafficFineBinding implements Bindings {
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

    TrafficFineDatasource tfDatasource = TrafficFineDatasourceImp(_dio);
    TrafficFineRepository tfRepository = TrafficFineRepositoryImp(tfDatasource);
    GetAllTrafficFineUsecase getTfUseCase =
        GetAllTrafficFineUsecaseImp(tfRepository);
    SaveTrafficUsecase saveTfUseCase = SaveTrafficUsecaseImp(tfRepository);
    UploadFileUsecase uploadFileUseCase = UploadFileUsecaseImp(tfRepository);
    GetTrafficFineUsecase getTrafficFine =
        GetTrafficFineUsecaseImp(tfRepository);

    Get.put(
      CopTrafficFineController(
        getAllTrafficFines: getTfUseCase,
        saveTrafficFine: saveTfUseCase,
        uploadFile: uploadFileUseCase,
        getTrafficFine: getTrafficFine,
      ),
    );
  }
}
