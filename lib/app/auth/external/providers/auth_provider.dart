import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthorizationProvider {
  final FlutterSecureStorage storage;

  AuthorizationProvider(this.storage);

  Future<String?> getAccessToken() async => await storage.read(key: 'token');

  Future<String?> getWarningPageAtFirst() async =>
      await storage.read(key: 'warning');

  Future<void> setToHideWarningPageAtFirst() async =>
      await storage.write(key: 'warning', value: "hide");
}
