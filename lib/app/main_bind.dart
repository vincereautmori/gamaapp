import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/shared/config/dio.dart';
import 'package:get/get.dart';

import '/app/auth/domain/usecases/clearSecureStorage/clear_secure_storage_usecase.dart';
import '/app/auth/domain/usecases/clearSecureStorage/clear_secure_storage_usecase_imp.dart';
import '/app/auth/domain/usecases/loadSecureToken/load_secure_token_usecase.dart';
import '/app/auth/domain/usecases/loadSecureToken/load_secure_token_usecase_imp.dart';
import '/app/auth/domain/usecases/signOut/signout_usecase.dart';
import '/app/auth/domain/usecases/signOut/signout_usecase_imp.dart';
import '/app/auth/presenter/controllers/splashscreen_controller.dart';
import 'auth/domain/repositories/authentication_repository.dart';
import 'auth/domain/repositories/cache_repository.dart';
import 'auth/domain/usecases/saveSecureToken/save_secure_token_usecase.dart';
import 'auth/domain/usecases/saveSecureToken/save_secure_token_usecase_imp.dart';
import 'auth/domain/usecases/signIn/sign_in_usecase.dart';
import 'auth/domain/usecases/signIn/sign_in_usecase_imp.dart';
import 'auth/external/datasources/authentication_datasource_imp.dart';
import 'auth/external/datasources/cache_datasource_imp.dart';
import 'auth/infra/datasources/authentication_datasource.dart';
import 'auth/infra/datasources/cache_datasource.dart';
import 'auth/infra/repositories/authentication_repository.dart';
import 'auth/infra/repositories/cache_storage_repository_imp.dart';
import 'auth/presenter/controllers/sign_in_controller.dart';

class MainBind extends Bindings {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void dependencies() {
    Dio dio = Api().dio;

    AuthenticationDatasource dataSource = AuthenticationDatasourceImp(dio);
    CacheStorageDatasource cacheDataSource =
        CacheStorageDatasourceImp(secureStorage: _secureStorage);

    AuthenticationRepository repository =
        AuthenticationRepositoryImp(dataSource);
    CacheStorageRepository cacheRepository =
        CacheStorageRepositoryImp(datasource: cacheDataSource);

    SignInUseCase useCase = SignInUseCaseImp(repository: repository);
    SignOutUseCase logoutUseCase = SignOutUseCaseImp(repository);

    SaveSecureToken saveSecureUseCase =
        SaveSecureTokenImp(repository: cacheRepository);
    LoadSecureToken loadSecureUseCase =
        LoadSecureTokenImp(repository: cacheRepository);
    ClearSecureStorage clearSecure =
        ClearSecureStorageImp(repository: cacheRepository);

    Get.put(
      AuthenticationController(
        authUseCase: useCase,
        logoutUseCase: logoutUseCase,
        saveSecureToken: saveSecureUseCase,
        clearSecureStorage: clearSecure,
      ),
      permanent: true,
    );
    Get.put(SplashscreenController(loadSecureUseCase));
  }
}
