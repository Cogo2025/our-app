import 'package:flutter/material.dart';
import './features//splash/splash-screen.dart';
import 'core/theme/light_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme, // Applying light theme
      home: SplashScreen(),
    );
  }
}
