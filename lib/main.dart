import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(TypingApp());
}

class TypingApp extends StatefulWidget {
  @override
  _TypingAppState createState() => _TypingAppState();
}

class _TypingAppState extends State<TypingApp> {
  List<String> typedWords = [];
  List<String> sentences = [
    "Hello world",
    "Flutter is amazing",
    "Typing speed test",
    "Welcome to adaptive typing",
    "Let's build something cool",
  ];

  void addWord(String word) {
    setState(() {
      typedWords.add(word);
    });

    Timer(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          if (typedWords.isNotEmpty) {
            typedWords.removeAt(0);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF1F1F1F),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  _buildButton(left: 100, top: 50, text: sentences[0]),
                  _buildButton(left: 300, top: 20, text: sentences[1]),
                  _buildButton(right: 300, top: 20, text: sentences[2]),
                  _buildButton(right: 100, top: 50, text: sentences[3]),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 80), // Increased margins
                child: Center(
                  child: Text(
                    typedWords.join(" "),
                    style: TextStyle(color: Colors.white, fontSize: 18), // Smaller font size
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({double? left, double? right, required double top, required String text}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      child: SizedBox(
        width: 120,
        height: 220,
        child: ElevatedButton(
          onPressed: () => addWord(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[800],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(text, style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        ),
      ),
    );
  }
}