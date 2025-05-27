// main.dart
import 'package:flutter/material.dart';
import 'UI/pages/ExplorePage.dart';
import 'UI/pages/HomePage.dart';
import 'UI/pages/ProfilePage.dart';
import 'UI/pages/ReviewsPage.dart';
import 'providers/album_provider.dart';
import 'models/support/app_constants.dart';

void main() {
  runApp(MainApp());
}

/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
      ],
      child: MaterialApp(
        title: 'Album Reviews',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: MaterialColor(
            AppConstants.primaryColorHex,
            <int, Color>{
              50: Color(AppConstants.primaryColorHex).withOpacity(0.1),
              100: Color(AppConstants.primaryColorHex).withOpacity(0.2),
              200: Color(AppConstants.primaryColorHex).withOpacity(0.3),
              300: Color(AppConstants.primaryColorHex).withOpacity(0.4),
              400: Color(AppConstants.primaryColorHex).withOpacity(0.5),
              500: Color(AppConstants.primaryColorHex),
              600: Color(AppConstants.primaryColorHex).withOpacity(0.7),
              700: Color(AppConstants.primaryColorHex).withOpacity(0.8),
              800: Color(AppConstants.primaryColorHex).withOpacity(0.9),
              900: Color(AppConstants.primaryColorHex),
            },
          ),
          fontFamily: 'SF Pro Display',
          visualDensity: VisualDensity.adaptivePlatformDensity,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(AppConstants.primaryColorHex),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
              ),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}

 */
class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recensioni Musicali',
      theme: ThemeData.dark(),
      home: MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  @override
  _MainNavigationState createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    ExplorePage(),
    ReviewsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Esplora'),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review), label: 'Recensioni'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profilo'),
        ],
      ),
    );
  }
}