import 'package:gamaapp/app/login/domain/errors/errors.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../domain/repositories/cache_repository.dart';
import '../datasources/cache_datasource.dart';

class CacheStorageRepositoryImp implements CacheStorageRepository {
  final CacheStorageDatasource datasource;

  CacheStorageRepositoryImp({required this.datasource});

  @override
  Future<Result<Unit, Failure>> saveSecure(
      {required String key, required String value}) async {
    try {
      await datasource.saveSecure(key: key, token: value);
      return const Success(unit);
    } catch (e) {
      return Error(
        CacheError(
          message: "Algo deu errado!",
        ),
      );
    }
  }
}
