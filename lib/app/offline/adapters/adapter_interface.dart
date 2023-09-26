import '../models/offline_model_interface.dart';

abstract class ICacheAdapter {
  Future<CacheModel?> get(String id);
  Future<void> put(CacheModel data);
}
