import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const VimoApp());
}

class VimoApp extends StatelessWidget {
  const VimoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VIMO',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: const Color(0xFFF4F4F4),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
