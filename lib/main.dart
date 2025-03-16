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
      if (typedWords.length > 6) {
        typedWords.removeAt(0); // Remove top line like a teleprompter
      }
    });

    Timer(Duration(seconds: 5), () {
      if (mounted && typedWords.isNotEmpty) {
        setState(() {
          typedWords.removeAt(0); // Auto-remove oldest word after 5 seconds
        });
      }
    });
  }

  void removeLastWord() {
    setState(() {
      if (typedWords.isNotEmpty) {
        typedWords.removeLast();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF1F1F1F),
        body: Stack(
          children: [
            Column(
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
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity: typedWords.length >= 3 ? 0.5 : 1.0,
                          duration: Duration(seconds: 1),
                          child: Container(
                            width: double.infinity,
                            height: 80,
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                typedWords.join(" "),
                                style: TextStyle(color: Colors.white, fontSize: 18),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 1,
              bottom: 1,
              child: GestureDetector(
                onTap: removeLastWord,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: Center(
                    child: Icon(Icons.backspace, color: Colors.white, size: 15),
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
        height: 180,
        child: ElevatedButton(
          onPressed: () => addWord(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[700],
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