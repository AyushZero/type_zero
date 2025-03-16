import 'package:flutter/material.dart';
import '../widgets/word_button.dart';
import '../widgets/backspace_button.dart';
import '../models/word_suggestions.dart';
import 'dart:async';

class TypingScreen extends StatefulWidget {
  @override
  _TypingScreenState createState() => _TypingScreenState();
}

class _TypingScreenState extends State<TypingScreen> {
  String currentSentence = "";
  Timer? sentenceTimer;
  Timer? fullStopTimer;
  List<String> availableWords = WordSuggestions.initialWords(); // Ensure words are available on start

  void addWord(String word) {
    setState(() {
      currentSentence += currentSentence.isEmpty ? word : " $word";
      availableWords = WordSuggestions.getNextSuggestions(word);
    });

    // Automatically remove the last sentence after 3 seconds
    Timer(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          int firstPeriod = currentSentence.indexOf(".");
          if (firstPeriod != -1 && firstPeriod + 1 < currentSentence.length) {
            currentSentence = currentSentence.substring(firstPeriod + 1).trim();
          } else {
            currentSentence = ""; // Clear the last sentence when it's the only one left
          }
        });
      }
    });


    // Add a full stop automatically after 0.5 seconds
    fullStopTimer?.cancel();
    fullStopTimer = Timer(Duration(milliseconds: 500), () {
      if (mounted && currentSentence.isNotEmpty && !currentSentence.endsWith(".")) {
        setState(() {
          currentSentence += ".";
          availableWords = WordSuggestions.initialWords(); // Reset words after full stop
        });
      }
    });
  }


  void removeLastWord() {
    setState(() {
      List<String> words = currentSentence.split(" ");
      if (words.isNotEmpty) {
        words.removeLast();
        currentSentence = words.join(" ");

        // Ensure available words never disappear
        availableWords = words.isNotEmpty ? WordSuggestions.getNextSuggestions(words.last) : WordSuggestions.initialWords();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(children: [_buildWordButtons()]),
              ),
              SizedBox(height: 10), // Reduce spacing
              Container(
                width: MediaQuery.of(context).size.width * 0.6, // Reduced width
                height: 50, // Adjusted height
                margin: EdgeInsets.only(bottom: 20), // Moves it slightly upwards
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    currentSentence,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

            ],
          ),
          BackspaceButton(onTap: removeLastWord),
        ],
      ),
    );
  }

  Widget _buildWordButtons() {
    return Stack(
      children: [
        if (availableWords.length > 0) WordButton(left: 150, top: 100, text: availableWords[0], onPressed: () => addWord(availableWords[0])),
        if (availableWords.length > 1) WordButton(left: 300, top: 50, text: availableWords[1], onPressed: () => addWord(availableWords[1])),
        if (availableWords.length > 2) WordButton(right: 300, top: 50, text: availableWords[2], onPressed: () => addWord(availableWords[2])),
        if (availableWords.length > 3) WordButton(right: 150, top: 100, text: availableWords[3], onPressed: () => addWord(availableWords[3])),
      ],
    );
  }
}
