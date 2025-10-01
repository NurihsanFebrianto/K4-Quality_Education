import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'screens/quiz_page.dart';
import 'screens/settings_page.dart';
import 'screens/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Color(0xFFF5F7FA), // Background abu-abu terang
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Tambahan untuk konsistensi UI
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF667eea),
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/quiz': (context) => QuizPage(),
        '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
