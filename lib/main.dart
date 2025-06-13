// lib/main.dart
import 'package:flutter/material.dart';
import 'package:frontend_psw/token_storage.dart';
import 'package:go_router/go_router.dart';

import 'UI/pages/app_shell.dart';
import 'UI/pages/login_page.dart';
import 'UI/pages/redirect_page.dart';
import 'main_navigation.dart';  // il tuo file con MainNavigation

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({Key? key}) : super(key: key);

  // Esempio di guard: controlla se ho token salvato
  bool get isLoggedIn => TokenStorage.hasToken();

  late final _router = GoRouter(
    initialLocation: isLoggedIn ? '/app' : '/',
    redirect: (context, state) {
      final loggedIn = TokenStorage.hasToken();
      final goingToLogin = state.subloc == '/';
      if (!loggedIn && !goingToLogin) return '/';
      if (loggedIn && goingToLogin) return '/app';
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => LoginPage()),
      GoRoute(
        path: '/redirect',
        builder: (ctx, state) => RedirectPage(
          code: state.queryParams['code'],
          error: state.queryParams['error'],
        ),
      ),
      GoRoute(path: '/app', builder: (_, __) => AppShell()),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Recensioni Musicali',
      theme: ThemeData.dark(),
      routerConfig: _router,
    );
  }
}