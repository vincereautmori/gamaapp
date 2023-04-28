import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../infra/datasources/cache_datasource.dart';

class CacheStorageDatasourceImp implements CacheStorageDatasource {
  final FlutterSecureStorage secureStorage;

  CacheStorageDatasourceImp({required this.secureStorage});
  @override
  Future<void> saveSecure({required String key, required String token}) async {
    await secureStorage.write(key: key, value: token);
  }

  @override
  Future<String> loadSecure(String key) {
    // TODO: implement loadSecure
    throw UnimplementedError();
  }
}
