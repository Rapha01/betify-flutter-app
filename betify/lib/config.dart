import 'dart:io' show Platform;

class Config {
  static final Config _singleton = Config._internal();
  factory Config() => _singleton;
  Config._internal();
  
  final String env = 'dev';
  String apiUrl = '';

  initConfig() {
    if (env == 'dev') {
      apiUrl = Platform.isAndroid ? 'http://10.0.2.2:3005/v1' : 'http://localhost:3005/v1';
    } else if (env == 'prod') {
      apiUrl = 'https://';
    }
  }
  
}