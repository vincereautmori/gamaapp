import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../infra/datasources/cache_datasource.dart';

class CacheStorageDatasourceImp implements CacheStorageDatasource {
  final FlutterSecureStorage secureStorage;

  CacheStorageDatasourceImp({required this.secureStorage});
  @override
  Future<void> saveSecure<T>({required String key, required T value}) async {
    await secureStorage.write(key: key, value: value.toString());
  }

  @override
  Future<Map<String, String>> loadSecure() async {
    return await secureStorage.readAll();
  }

  @override
  Future<void> clearSecure() async {
    await secureStorage.deleteAll();
  }
}
