import 'package:flutter/material.dart';

void main() {
  runApp(TypingApp());
}

class TypingApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF1F1F1F),
        body: Stack(
          children: [
            Positioned(
              left: 50,
              top: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Word 1'),
              ),
            ),
            Positioned(
              right: 50,
              top: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Word 2'),
              ),
            ),
            Positioned(
              left: 50,
              bottom: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Word 3'),
              ),
            ),
            Positioned(
              right: 50,
              bottom: 100,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Word 4'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
