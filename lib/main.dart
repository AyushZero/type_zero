import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                padding: EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        typedWords.join(" "),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: removeLastWord,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Backspace", style: TextStyle(color: Colors.white)),
                    ),
                  ],
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