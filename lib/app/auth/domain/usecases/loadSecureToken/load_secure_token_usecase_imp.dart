import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth.dart';
import '../../errors/errors.dart';
import '../../repositories/cache_repository.dart';
import 'load_secure_token_usecase.dart';

class LoadSecureTokenImp implements LoadSecureToken {
  final CacheStorageRepository repository;

  LoadSecureTokenImp({required this.repository});

  @override
  Future<Result<AuthEntity, Failure>> load() async {
    final result = await repository.fetchSecure('token');

    if (result.isError()) {
      return Error(CacheError(message: "Falha ao carregar token"));
    }

    return Success(
        AuthEntity(internalCode: 200, token: result.tryGetSuccess() ?? ""));
  }
}
