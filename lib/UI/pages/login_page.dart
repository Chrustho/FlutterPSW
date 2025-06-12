// lib/UI/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../auth/auth_service.dart';
import '../../token_storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _callbackHandled = false;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // 1) gestisco la callback (se arrivo su /redirect)
    try {
      await AuthService.handleAuthCallback();
      // 2) se ho un token già salvato vado direttamente ad /app
      if (TokenStorage.hasToken()) {
        GoRouter.of(context).go('/app');
        return;
      }
    } catch (e) {
      _error = e.toString();
    }
    setState(() {
      _loading = false;
      _callbackHandled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      body: Center(
        child: _callbackHandled
            ? Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_error != null) ...[
              Text('Errore: $_error', style: TextStyle(color: Colors.red)),
              SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: AuthService.login,  // qui chiamo solo login()
              child: Text('Login / Registrazione'),
            ),
          ],
        )
            : CircularProgressIndicator(),
      ),
    );
  }
}
