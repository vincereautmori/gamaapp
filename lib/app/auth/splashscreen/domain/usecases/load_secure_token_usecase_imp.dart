import 'package:multiple_result/multiple_result.dart';

import '../../../login/domain/entities/auth/auth.dart';
import '../../../login/domain/errors/errors.dart';
import '../../../login/domain/repositories/cache_repository.dart';
import 'load_secure_token_usecase.dart';

class LoadSecureTokenImp implements LoadSecureToken {
  final CacheStorageRepository repository;

  LoadSecureTokenImp({required this.repository});

  @override
  Future<Result<Unit, Failure>> save(AuthEntity account) async {
    if (!account.success) {
      return Error(CacheError(message: "Falha ao salvar token"));
    }

    final result =
        await repository.saveSecure(key: 'token', value: account.token);

    return result;
  }
}
