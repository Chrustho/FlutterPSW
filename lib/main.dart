// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/album_provider.dart';
import 'models/support/app_constants.dart';

void main() {
  runApp(MyApp());
}

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