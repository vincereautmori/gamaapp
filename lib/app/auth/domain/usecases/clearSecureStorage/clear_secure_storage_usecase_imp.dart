import 'package:gamaapp/app/auth/domain/errors/errors.dart';
import 'package:gamaapp/app/auth/domain/repositories/cache_repository.dart';
import 'package:gamaapp/app/auth/domain/usecases/clearSecureStorage/clear_secure_storage_usecase.dart';
import 'package:multiple_result/multiple_result.dart';

class ClearSecureStorageImp implements ClearSecureStorage {
  final CacheStorageRepository repository;

  ClearSecureStorageImp({required this.repository});

  @override
  Future<Result<Unit, Failure>> clear() async {
    return await repository.clearSecure();
  }
}
