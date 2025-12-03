import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static late final String uid;
  static late final String secret;
  static late final String redirectUrl;
  static late final String baseUrl;
  static late final String authorizeUrl;
  static late final String tokenUrl;
  static late final String customUriScheme;

  static Future<void> load({String fileName = '.env'}) async {
    await dotenv.load(fileName: fileName);

    uid = _get('uid');
    secret = _get('secret');
    redirectUrl = _get('redirect_url');
    baseUrl = _get('base_url');
    authorizeUrl = _get('tokenUrl');
    tokenUrl = _get('tokenUrl');
    customUriScheme = _get('customUriScheme');
  }

  static String _get(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw Exception('Environment variable "$key" is not set.');
    }
    return value;
  }
}
