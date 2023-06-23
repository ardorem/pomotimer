import 'package:flutter/material.dart';
import 'package:pomotimer/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            backgroundColor: const Color(0xFFE64D3D),
          ),
          focusColor: const Color(0xFF3D86E6),
          textTheme: const TextTheme(
            displayMedium: TextStyle(
              color: Color(0xFFE64D3D),
            ),
            displaySmall: TextStyle(
              color: Color(0xFFE64D3D),
            ),
          )),
      home: const HomeScreen(),
    );
  }
}
