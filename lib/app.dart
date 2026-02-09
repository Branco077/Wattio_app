import 'package:flutter/material.dart';
import 'pages/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B3A46),
          primary: const Color(0xFF0B3A46),
          secondary: const Color(0xFFF7E400),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B3A46),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF7E400),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
