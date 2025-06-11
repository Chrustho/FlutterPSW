import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../token_storage.dart';
import 'auth_service.dart';

class ApiService {
  final AuthService _authService = AuthService();
  final String _baseUrl = 'http://localhost:8082';

  /// Restituisce sempre un token valido:
  /// - su Web: lo legge da localStorage
  /// - su Mobile: invoca il flow OIDC e salva
  Future<String?> _getValidToken() async {
    if (kIsWeb) {
      // sul Web abbiamo già salvato il token in TokenStorage
      return TokenStorage.readToken();
    } else {
      // su Mobile lanciamo il flow
      final result = await _authService.signIn();
      final token = result?.accessToken;
      if (token != null) {
        TokenStorage.saveToken(token);
      }
      return token;
    }
  }

  Future<http.Response> getProtectedResource(String path) async {
    final token = await _getValidToken();
    if (token == null) {
      throw Exception('Non sono riuscito a recuperare un token valido');
    }
    final uri = Uri.parse('$_baseUrl$path');
    return http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
  }
}
