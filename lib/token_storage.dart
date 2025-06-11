// lib/token_storage.dart
import 'dart:html' as html; // Web

class TokenStorage {
  static const _key = 'access_token';

  static bool hasToken() => html.window.localStorage.containsKey(_key);

  static String? readToken() => html.window.localStorage[_key];

  static void saveToken(String token) => html.window.localStorage[_key] = token;

  static void clear() => html.window.localStorage.remove(_key);
}
