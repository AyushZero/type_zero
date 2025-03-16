import 'package:flutter/material.dart';
import 'screens/typing_screen.dart';

void main() {
  runApp(TypingApp());
}

class TypingApp extends StatelessWidget {
  const TypingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TypingScreen(),
    );
  }
}
