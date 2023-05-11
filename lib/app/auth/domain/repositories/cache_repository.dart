import 'package:multiple_result/multiple_result.dart';

import '../../domain/errors/errors.dart';

abstract class CacheStorageRepository {
  Future<Result<Unit, Failure>> saveSecure<T>(
      {required String key, required T value});

  Future<Result<Map<String, String>, Failure>> fetchSecure();
}
