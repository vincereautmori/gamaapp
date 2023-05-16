abstract class CacheStorageDatasource {
  Future<void> saveSecure<T>({
    required String key,
    required T value,
  });

  Future<Map<String, String>> loadSecure();

  Future<void> clearSecure();
}
