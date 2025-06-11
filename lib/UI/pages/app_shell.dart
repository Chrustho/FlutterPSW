// lib/UI/app_shell.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '';
import 'HomePage.dart'; // o ProfilePage
import 'MainNavigation.dart';

class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  // Le tue pagine corrispondono agli indici 0,1,2
  static final List<Widget> _pages = [
    HomePage(),
    //ReviewsPage(),
    //AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MainNavigation riceve selectedIndex e un callback
      bottomNavigationBar: MainNavigation(
        selectedIndex: _selectedIndex,
        onItemSelected: (idx) => setState(() => _selectedIndex = idx),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
