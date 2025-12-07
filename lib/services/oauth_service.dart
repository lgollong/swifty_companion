import '../config/env.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OAuthService {
  OAuthService._();
  static final OAuthService instance = OAuthService._();

  late final OAuth2Client _client;
  late final OAuth2Helper _helper;

  void init() {
    _client = OAuth2Client(
      authorizeUrl: Env.authorizeUrl,
      tokenUrl: Env.tokenUrl,
      redirectUri: Env.redirectUrl,
      customUriScheme: Env.customUriScheme,
    );

    _helper = OAuth2Helper(
      _client,
      clientId: Env.uid,
      clientSecret: Env.secret,
      grantType: OAuth2Helper.clientCredentials,
      scopes: ['public'],
      enablePKCE: false,
    );
  }

  Future<String?> getAccessToken() async {
    final tokenResponse = await _helper.getToken();
    return tokenResponse?.accessToken;
  }

  Future<void> clearToken() async {
    await _helper.removeAllTokens();
  }
}
