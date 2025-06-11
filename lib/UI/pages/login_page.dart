// lib/UI/pages/login_page.dart (o dove preferisci)
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:frontend_psw/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  void _login() {
    final authUrl = AuthService.buildAuthorizationUrl();
    html.window.location.href = authUrl.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _login,
          child: Text('Login / Registrazione'),
        ),
      ),
    );
  }
}