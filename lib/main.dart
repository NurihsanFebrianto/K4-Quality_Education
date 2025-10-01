import 'package:flutter/material.dart';
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
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // langsung ke HomePage
      home: HomePage(),
      routes: {
        '/home': (context) => HomePage(),
        '/quiz': (context) => QuizPage(),
        '/settings': (context) => SettingsPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
