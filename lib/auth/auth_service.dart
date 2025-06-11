// lib/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TokenResponse {
  final String accessToken;
  final String idToken;
  final int expiresIn;
  TokenResponse({
    required this.accessToken,
    required this.idToken,
    required this.expiresIn,
  });
}

class AuthService {
  static const _issuer      = 'http://localhost:8080/realms/ProgettoPSW';
  static const _clientId    = 'TestClient';
  static const _redirectUri = 'http://localhost:8083/redirect';
  static const _scopes      = ['openid', 'profile', 'email'];

  /// Costruisce l'URL di autorizzazione Keycloak
  static Uri buildAuthorizationUrl() {
    final scope = _scopes.join('%20');
    return Uri.parse(
        '$_issuer/protocol/openid-connect/auth'
            '?response_type=code'
            '&client_id=$_clientId'
            '&redirect_uri=$_redirectUri'
            '&scope=$scope'
    );
  }

  /// Scambia il code ricevuto via Web con i token JWT
  static Future<TokenResponse?> exchangeCode(String code) async {
    final tokenUrl = '$_issuer/protocol/openid-connect/token';
    final resp = await http.post(
      Uri.parse(tokenUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'client_id': _clientId,
        'redirect_uri': _redirectUri,
        'code': code,
      },
    );
    if (resp.statusCode == 200) {
      final j = jsonDecode(resp.body);
      return TokenResponse(
        accessToken: j['access_token'],
        idToken: j['id_token'],
        expiresIn: j['expires_in'],
      );
    }
    return null;
  }


}