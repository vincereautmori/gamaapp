import 'package:multiple_result/multiple_result.dart';

import '../../domain/errors/errors.dart';
import '../../domain/repositories/cache_repository.dart';
import '../datasources/cache_datasource.dart';

class CacheStorageRepositoryImp implements CacheStorageRepository {
  final CacheStorageDatasource datasource;

  CacheStorageRepositoryImp({required this.datasource});

  @override
  Future<Result<Unit, Failure>> saveSecure<T>(
      {required String key, required T value}) async {
    try {
      await datasource.saveSecure<T>(key: key, value: value);
      return const Success(unit);
    } catch (e) {
      return Error(
        CacheError(
          message: "Algo deu errado!",
        ),
      );
    }
  }

  @override
  Future<Result<Map<String, String>, Failure>> fetchSecure() async {
    try {
      Map<String, String> secureData = await datasource.loadSecure();
      return Success(secureData);
    } catch (e) {
      return Error(
        CacheError(
          message: "Algo deu errado!",
        ),
      );
    }
  }
}
