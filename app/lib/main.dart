import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const BiologyResearchApp());
}

class BiologyResearchApp extends StatelessWidget {
  const BiologyResearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biology Research App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
