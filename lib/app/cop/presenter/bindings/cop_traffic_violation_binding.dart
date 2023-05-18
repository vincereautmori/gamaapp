import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/app/cop/presenter/controllers/cop_traffic_violation_controller.dart';
import 'package:get/get.dart';

import '../../../auth/domain/repositories/cache_repository.dart';
import '../../../auth/domain/usecases/loadSecureToken/load_secure_token_usecase.dart';
import '../../../auth/domain/usecases/loadSecureToken/load_secure_token_usecase_imp.dart';
import '../../../auth/external/datasources/cache_datasource_imp.dart';
import '../../../auth/infra/datasources/cache_datasource.dart';
import '../../../auth/infra/repositories/cache_storage_repository_imp.dart';

class CopTrafficViolationBinding implements Bindings {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  void dependencies() {
    CacheStorageDatasource cacheDataSource =
        CacheStorageDatasourceImp(secureStorage: _secureStorage);

    CacheStorageRepository cacheRepository =
        CacheStorageRepositoryImp(datasource: cacheDataSource);

    LoadSecureToken loadSecureUseCase =
        LoadSecureTokenImp(repository: cacheRepository);

    Get.lazyPut(() => CopTrafficViolationController(loadSecureUseCase),
        fenix: true);
  }
}
