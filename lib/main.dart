// lib/main.dart
import 'package:flutter/material.dart';
import 'package:frontend_psw/UI/pages/HomePage.dart';
import 'package:go_router/go_router.dart';
import 'UI/pages/app_shell.dart';
import 'token_storage.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final _router = GoRouter(
    initialLocation: TokenStorage.hasToken() ? '/app' : '/',
    routes: [
      GoRoute(path: '/',       builder: (_, __) => HomePage()),
      //GoRoute(path: '/redirect', builder: (_, __) => RedirectPage()),
      GoRoute(path: '/app',    builder: (_, __) => AppShell()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recensioni Musicali',
      routerConfig: _router,
      theme: ThemeData.light(),
    );
  }
}
