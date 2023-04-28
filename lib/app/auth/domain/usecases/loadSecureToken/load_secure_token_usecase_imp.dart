import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth.dart';
import '../../errors/errors.dart';
import '../../repositories/cache_repository.dart';
import 'load_secure_token_usecase.dart';

class LoadSecureTokenImp implements LoadSecureToken {
  final CacheStorageRepository repository;

  LoadSecureTokenImp({required this.repository});

  @override
  Future<Result<AuthEntity, Failure>> load(AuthEntity account) async {
    if (!account.success) {
      return Error(CacheError(message: "Falha ao salvar token"));
    }

    final result =
        await repository.saveSecure(key: 'token', value: account.token);

    return const Success(AuthEntity(internalCode: 200, token: 'token'));
  }
}
