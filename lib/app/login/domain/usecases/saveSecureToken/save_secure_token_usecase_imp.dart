import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth.dart';
import '../../errors/errors.dart';
import '../../repositories/cache_repository.dart';
import 'save_secure_token_usecase.dart';

class SaveSecureTokenImp implements SaveSecureToken {
  final CacheStorageRepository repository;

  SaveSecureTokenImp({required this.repository});

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