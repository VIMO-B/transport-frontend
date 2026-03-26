import 'package:flutter/material.dart';
import 'screens/splash/splash_screen.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('es_ES', null); // 🔥 ESTO FALTABA

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