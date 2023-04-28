import 'package:multiple_result/multiple_result.dart';

import '../../domain/errors/errors.dart';

abstract class CacheStorageRepository {
  Future<Result<Unit, Failure>> saveSecure(
      {required String key, required String value});
}
