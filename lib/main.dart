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
  String currentSentence = "";
  Timer? sentenceTimer;
  Map<String, List<String>> wordChains = {
    "": ["I", "You", "We", "They"],
    "I": ["am", "will", "like", "have"],
    "You": ["are", "will", "want", "need"],
    "We": ["should", "can", "have", "love"],
    "They": ["do", "might", "enjoy", "prefer"],
    "am": ["happy", "tired", "ready", "here"],
    "will": ["go", "stay", "help", "wait"],
    "like": ["this", "that", "playing", "coding"],
  };
  List<String> availableWords = ["I", "You", "We", "They"];
  Timer? fullStopTimer;

  void addWord(String word) {
    setState(() {
      currentSentence += (currentSentence.isEmpty ? "" : " ") + word;
      availableWords = wordChains[word] ?? [];

      fullStopTimer?.cancel();
      fullStopTimer = Timer(Duration(milliseconds: 500), () {
        if (mounted && currentSentence.isNotEmpty && !currentSentence.endsWith(".")) {
          setState(() {
            currentSentence += ".";
            availableWords = ["I", "You", "We", "They"];
          });
        }
      });

      sentenceTimer?.cancel();
      sentenceTimer = Timer(Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            currentSentence = "";
          });
        }
      });
    });
  }

  void removeLastWord() {
    setState(() {
      List<String> words = currentSentence.split(" ");
      if (words.isNotEmpty) {
        words.removeLast();
        currentSentence = words.join(" ");
        availableWords = wordChains[words.isNotEmpty ? words.last : ""] ?? ["I", "You", "We", "They"];
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
                      _buildButton(left: 150, top: 100, text: availableWords.isNotEmpty ? availableWords[0] : ""),
                      _buildButton(left: 300, top: 50, text: availableWords.length > 1 ? availableWords[1] : ""),
                      _buildButton(right: 300, top: 50, text: availableWords.length > 2 ? availableWords[2] : ""),
                      _buildButton(right: 150, top: 100, text: availableWords.length > 3 ? availableWords[3] : ""),
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
                          width: double.infinity,
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(currentSentence, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center),
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
        height: 160,
        child: ElevatedButton(
          onPressed: text.isNotEmpty ? () => addWord(text) : null,
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
