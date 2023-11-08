import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static String get coreApiUrl => _getDotEnvVariableValue("CORE_API_URL");
  static String get socketUrl => _getDotEnvVariableValue("SOCKET_URL");
  static String get mapBoxBaseUrl => _getDotEnvVariableValue("MAPBOX_URL");

  static String _getDotEnvVariableValue(String name) => dotenv.env[name] ?? "";
}
