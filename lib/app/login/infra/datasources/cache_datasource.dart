abstract class CacheStorageDatasource {
  Future<void> saveSecure({
    required String key,
    required String token,
  });
}
