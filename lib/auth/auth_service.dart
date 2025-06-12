// lib/auth_service.dart
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import '../token_storage.dart';

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
  static const _verifierKey = 'pkce_verifier';

  /// Costruisce l'URL di autorizzazione Keycloak
  static Uri buildAuthorizationUrl() {
    final verifier  = _createVerifier();
    final challenge = verifier; // plain: challenge == verifier
    final scope     = _scopes.join('%20');
    return Uri.parse(
        '$_issuer/protocol/openid-connect/auth'
            '?response_type=code'
            '&client_id=$_clientId'
            '&redirect_uri=$_redirectUri'
            '&scope=$scope'
            '&code_challenge=$challenge'
            '&code_challenge_method=plain'
    );
  }

  /// Scambia il code ricevuto via Web con i token JWT
  static Future<TokenResponse?> exchangeCode(String code) async {
    final verifier = html.window.localStorage[_verifierKey];
    final resp = await http.post(
      Uri.parse('$_issuer/protocol/openid-connect/token'),
      headers: {'Content-Type':'application/x-www-form-urlencoded'},
      body: {
        'grant_type'   : 'authorization_code',
        'client_id'    : _clientId,
        'redirect_uri' : _redirectUri,
        'code'         : code,
        'code_verifier': verifier!,
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

  static String _createVerifier() {
    final rand = Random.secure();
    final bytes = List<int>.generate(64, (_) => rand.nextInt(256));
    final v = base64UrlEncode(bytes).replaceAll('=', '');
    html.window.localStorage[_verifierKey] = v;
    return v;
  }
  /// Il metodo che unifica login e callback handling
  // lib/auth_service.dart
  Future<void> signIn() async {
    final uri = Uri.base;
    final code = uri.queryParameters['code'];
    final error = uri.queryParameters['error'];

    if (error != null) {
      throw Exception('Keycloak error: $error');
    }

    if (code != null) {
      final tokens = await exchangeCode(code);
      if (tokens == null) {
        throw Exception('Exchange code failed');
      }
      TokenStorage.saveToken(tokens.accessToken);
      html.window.history.replaceState(null, 'App', '/');
      return;
    }

    // Se arrivo qui, significa che non ho code e devo partire col login
    final authUri = buildAuthorizationUrl();
    // Controllo rapide sullo URL
    if (!authUri.hasAbsolutePath || authUri.scheme != 'http') {
      throw Exception('URL di login non valido: $authUri');
    }
    // Usa assign() per forzare la navigazione
    html.window.location.assign(authUri.toString());
  }

  static Future<void> handleAuthCallback() async {
    final uri   = Uri.base;
    final code  = uri.queryParameters['code'];
    final error = uri.queryParameters['error'];

    if (error != null) {
      throw Exception('Keycloak error: $error');
    }
    if (code != null) {
      final tokens = await exchangeCode(code);
      if (tokens == null) throw Exception('Exchange code failed');
      TokenStorage.saveToken(tokens.accessToken);
      // Ripulisce la URL da ?code=…
      html.window.history.replaceState(null, 'App', '/');
      return;
    }
    // Se non c'è code, non faccio nulla
  }

  /// Da chiamare con il bottone: forza sempre l'apertura della pagina di login Keycloak
  static void login() {
    final authUri = buildAuthorizationUrl();
    html.window.location.assign(authUri.toString());
  }




}