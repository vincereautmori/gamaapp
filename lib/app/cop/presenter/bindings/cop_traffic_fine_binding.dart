import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/app/auth/external/providers/auth_provider.dart';
import 'package:gamaapp/app/cop/domain/usecases/getTrafficFine/get_traffic_fine_usecase.dart';
import 'package:gamaapp/app/cop/domain/usecases/uploadFile/upload_file_usecase_imp.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_fine_controller.dart';
import 'package:gamaapp/shared/config/dio.dart';
import 'package:get/get.dart';

import '../../domain/repositories/traffic_fine_repository.dart';
import '../../domain/usecases/getAllTrafficFines/get_all_traffic_fine_usecase.dart';
import '../../domain/usecases/getAllTrafficFines/get_all_traffic_fine_usecase_imp.dart';
import '../../domain/usecases/getTrafficFine/get_traffic_fine_usecase_imp.dart';
import '../../domain/usecases/loadFile/load_file_usecase.dart';
import '../../domain/usecases/loadFile/load_file_usecase_imp.dart';
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

  @override
  void dependencies() {
    Dio dio = Api().dio;

    TrafficFineDatasource tfDatasource = TrafficFineDatasourceImp(dio);

    TrafficFineRepository tfRepository = TrafficFineRepositoryImp(tfDatasource);

    GetAllTrafficFineUsecase getTfUseCase =
        GetAllTrafficFineUsecaseImp(tfRepository);

    SaveTrafficUsecase saveTfUseCase = SaveTrafficUsecaseImp(tfRepository);

    UploadFileUsecase uploadFileUseCase = UploadFileUsecaseImp(tfRepository);

    LoadFileUsecase loadFileUseCase = LoadFileUsecaseImp(tfRepository);

    GetTrafficFineUsecase getTrafficFine =
        GetTrafficFineUsecaseImp(tfRepository);

    Get.put(
      CopTrafficFineController(
        getAllTrafficFines: getTfUseCase,
        saveTrafficFine: saveTfUseCase,
        uploadFile: uploadFileUseCase,
        loadFile: loadFileUseCase,
        getTrafficFine: getTrafficFine,
      ),
    );
  }
}
