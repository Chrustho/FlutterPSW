// lib/main.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'UI/pages/app_shell.dart';

import 'token_storage.dart';
import 'UI/pages/login_page.dart';
import 'UI/pages/redirect_page.dart';


void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  // se c'è token, parto direttamente su /app
  final GoRouter _router = GoRouter(
    initialLocation: TokenStorage.hasToken() ? '/app' : '/',
    // redirect automatico in base allo stato di login
    redirect: (context, state) {
      final loggedIn = TokenStorage.hasToken();
      final goingToLogin = state.subloc == '/';
      if (!loggedIn && !goingToLogin) return '/';      // se non loggato e vado altrove, torna su login
      if (loggedIn && goingToLogin) return '/app';     // se loggato e torno su login, manda a /app
      return null;                                      // altrimenti non cambiare
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => LoginPage()),
      GoRoute(path: '/redirect', builder: (_, state) => RedirectPage(
        code: state.queryParams['code'],
        error: state.queryParams['error'],
      )),
      GoRoute(path: '/app', builder: (_, __) => AppShell()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recensioni Musicali',
      theme: ThemeData.light(),
      routerConfig: _router,
    );
  }
}
