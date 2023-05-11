import 'package:multiple_result/multiple_result.dart';

import '../../entities/auth/auth.dart';
import '../../errors/errors.dart';
import '../../repositories/cache_repository.dart';
import 'load_secure_token_usecase.dart';

class LoadSecureTokenImp implements LoadSecureToken {
  final CacheStorageRepository repository;

  LoadSecureTokenImp({required this.repository});

  void validateIfTokenHasExpired(AuthEntity auth) {}

  @override
  Future<Result<AuthEntity, Failure>> load() async {
    final result = await repository.fetchSecure();

    Map<String, String> secureData = result.tryGetSuccess() ?? {};

    return Success(AuthEntity(
        internalCode: int.parse(secureData['internalCode'] ?? "200"),
        token: secureData['token'] ?? "",
        expiresIn: double.parse(secureData['expiresIn'] ?? "0"),
        role: secureData['role'] ?? ""));
  }
}
