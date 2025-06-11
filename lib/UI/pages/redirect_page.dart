// lib/UI/pages/redirect_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_psw/auth/auth_service.dart';

import '../../token_storage.dart';

class RedirectPage extends StatefulWidget {
  final String? code;
  final String? error;
  const RedirectPage({this.code, this.error, Key? key}) : super(key: key);

  @override
  _RedirectPageState createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  String _message = 'Processando callback...';

  @override
  void initState() {
    super.initState();
    _handle();
  }

  Future<void> _handle() async {
    if (widget.error != null) {
      setState(() => _message = 'Errore: ${widget.error}');
      return;
    }
    final code = widget.code;
    if (code == null) {
      setState(() => _message = 'Nessun code ricevuto');
      return;
    }
    setState(() => _message = 'Scambio code con token...');
    final tokens = await AuthService.exchangeCode(code);
    if (tokens != null) {
      TokenStorage.saveToken(tokens.accessToken);
      GoRouter.of(context).go('/app');
    } else {
      setState(() => _message = 'Scambio token fallito');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_message)),
    );
  }
}