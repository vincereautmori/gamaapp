import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get coreApiUrl => _getDotEnvVariableValue("CORE_API_URL");
  static String get socketUrl => _getDotEnvVariableValue("SOCKET_URL");
  static String get mapBoxBaseUrl => _getDotEnvVariableValue("MAPBOX_BASE_URL");
  static String get mapAccessToken => _getDotEnvVariableValue("MAPBOX_TOKEN");

  static String _getDotEnvVariableValue(String name) => dotenv.env[name] ?? "";
}
