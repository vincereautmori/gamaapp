import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../shared/config/config.dart';
import 'login/domain/repositories/authentication_repository.dart';
import 'login/domain/repositories/cache_repository.dart';
import 'login/domain/usecases/saveSecureToken/save_secure_token_usecase.dart';
import 'login/domain/usecases/saveSecureToken/save_secure_token_usecase_imp.dart';
import 'login/domain/usecases/signIn/sign_in_usecase.dart';
import 'login/domain/usecases/signIn/sign_in_usecase_imp.dart';
import 'login/external/datasources/authentication_datasource_imp.dart';
import 'login/external/datasources/cache_datasource_imp.dart';
import 'login/infra/datasources/authentication_datasource.dart';
import 'login/infra/datasources/cache_datasource.dart';
import 'login/infra/repositories/authentication_repository.dart';
import 'login/infra/repositories/cache_storage_repository_imp.dart';
import 'login/presenter/controllers/sign_in_controller.dart';

class MainBind extends Bindings {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: Config.coreApiUrl),
  );

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void dependencies() {
    AuthenticationDatasource dataSource = AuthenticationDatasourceImp(_dio);
    CacheStorageDatasource cacheDataSource =
        CacheStorageDatasourceImp(secureStorage: _secureStorage);

    AuthenticationRepository repository =
        AuthenticationRepositoryImp(dataSource);
    CacheStorageRepository cacheRepository =
        CacheStorageRepositoryImp(datasource: cacheDataSource);

    SignInUseCase useCase = SignInUseCaseImp(repository: repository);
    SaveSecureToken cacheUseCase =
        SaveSecureTokenImp(repository: cacheRepository);

    Get.put(SignInController(useCase, cacheUseCase));
  }
}
