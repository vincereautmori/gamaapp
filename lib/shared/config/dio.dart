import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gamaapp/shared/config/config.dart';

import '../../app/auth/external/providers/auth_provider.dart';

class Api {
  final dio = createDio();

  Api._internal();

  static final _singleton = Api._internal();

  static final authorizationProvider =
      AuthorizationProvider(const FlutterSecureStorage());

  factory Api() => _singleton;

  static Dio createDio() {
    Dio dioInstance = Dio(
      BaseOptions(
        baseUrl: Config.coreApiUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
      ),
    );

    dioInstance.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await authorizationProvider.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        handler.next(options);
      },
    ));
    return dioInstance;
  }
}
